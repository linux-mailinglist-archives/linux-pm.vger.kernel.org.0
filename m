Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EBC33C5E2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCOSjV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhCOSjJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 14:39:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291E9C06174A;
        Mon, 15 Mar 2021 11:39:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 16so17483223ljc.11;
        Mon, 15 Mar 2021 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KO44h0uObgEN+CbJaeye5M8R+QLroU33+3EnpKPK0Zc=;
        b=Wcct+L78J7FhiuyEOC0azdpN42lEyaWldO9VbNqOm6WnWb2ACnpK2tS8sddTATuz8Z
         qEyiWx7qk5RhASZPKdfFqglj1M06gkN52WRdYYGMHRgT6y12FTWCz50SvFw+nKqudF0M
         E5SUe0QU+l2YnbixCqcUtkS0hfakWfgU/LwHOOG8bVt09Qi7RgjO2sdOAvxcAxjKvgRc
         3R25ze+FNE1lO/NygEp5Lo2zyPnwrTlkbCSGrn3mbckT8/0XcMcz3LsUX7n+aoeUVYD1
         geg3sanpe64KhyGqF5tofjAaBhLPVGyFyG3Meryb+bjmnOGUbzHRgJ3aDpzjy7kcAEln
         hmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KO44h0uObgEN+CbJaeye5M8R+QLroU33+3EnpKPK0Zc=;
        b=mMrEKBHW1ATQgjsWQkMzyuFxVlf7GF/8VetRaNKLPsIa9K3V2nI0pcELic0hgjXW0t
         aEA6BKINJt6WX3r9/48STxCGtQdDLctlS/1YJRkXWx6M6E2yNoY3esggqcxpvj8nR64f
         6iwwuENAsrEW5KrB5l+MD5neIBKKaPKGG9vCdd09P/gnw8ZBzPDwnLFAqM1vF2bK1AD/
         Nz9m96BWbise1WxDSXJ6MKNnvAWoevjyDF3Kf/uLTQS/FED1jutFtr6DgwSkFD2l6lrC
         SRosw2IoYRSVKwkeSOs6EPsUXRoaXeJY64WBRoiJZ3+z/hgfyf74pqcqzAK3M2JxRo8q
         PHtw==
X-Gm-Message-State: AOAM5312B4OrwdIm6j9zEnsA+kAUB9yTCWyAzNhT/j6WvnlLqmph2slZ
        uSe8VV1w4FoHKd+Kym3nDY2KLx3FVJo=
X-Google-Smtp-Source: ABdhPJzAzvUfdIh5PrIN5KmKthL6Ugz5Zq8SwLs888Jv/nqvzEK2iGbdWqRlP0OG/eAQSjvojwJRtw==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr235866ljh.332.1615833547675;
        Mon, 15 Mar 2021 11:39:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id z28sm2992541ljn.117.2021.03.15.11.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 11:39:07 -0700 (PDT)
Subject: Re: [PATCH v15 1/2] drm/tegra: dc: Support memory bandwidth
 management
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210311172255.25213-1-digetx@gmail.com>
 <20210311172255.25213-2-digetx@gmail.com>
 <20210314223119.GC2733@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1158bbca-8880-918d-7564-e2e30552e6b3@gmail.com>
Date:   Mon, 15 Mar 2021 21:39:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210314223119.GC2733@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.03.2021 01:31, Michał Mirosław пишет:
> On Thu, Mar 11, 2021 at 08:22:54PM +0300, Dmitry Osipenko wrote:
>> Display controller (DC) performs isochronous memory transfers, and thus,
>> has a requirement for a minimum memory bandwidth that shall be fulfilled,
>> otherwise framebuffer data can't be fetched fast enough and this results
>> in a DC's data-FIFO underflow that follows by a visual corruption.
> [...]
>> +static unsigned long
>> +tegra_plane_overlap_mask(struct drm_crtc_state *state,
>> +			 const struct drm_plane_state *plane_state)
>> +{
>> +	const struct drm_plane_state *other_state;
>> +	const struct tegra_plane *tegra;
>> +	unsigned long overlap_mask = 0;
>> +	struct drm_plane *plane;
>> +	struct drm_rect rect;
>> +
>> +	if (!plane_state->visible || !plane_state->fb)
>> +		return 0;
>> +
>> +	drm_atomic_crtc_state_for_each_plane_state(plane, other_state, state) {
> [...]
>> +	/*
>> +	 * Data-prefetch FIFO will easily help to overcome temporal memory
>> +	 * pressure if other plane overlaps with the cursor plane.
>> +	 */
>> +	if (tegra_plane_is_cursor(plane_state) && overlap_mask)
>> +		return 0;
>> +
>> +	return overlap_mask;
>> +}
> 
> Since for cursor plane this always returns 0, you could test
> tegra_plane_is_cursor() at the start of the function.

Yes, thanks.

>> +static int tegra_crtc_calculate_memory_bandwidth(struct drm_crtc *crtc,
>> +						 struct drm_atomic_state *state)
> [...]
>> +	/*
>> +	 * For overlapping planes pixel's data is fetched for each plane at
>> +	 * the same time, hence bandwidths are accumulated in this case.
>> +	 * This needs to be taken into account for calculating total bandwidth
>> +	 * consumed by all planes.
>> +	 *
>> +	 * Here we get the overlapping state of each plane, which is a
>> +	 * bitmask of plane indices telling with what planes there is an
>> +	 * overlap. Note that bitmask[plane] includes BIT(plane) in order
>> +	 * to make further code nicer and simpler.
>> +	 */
>> +	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, new_state) {
>> +		tegra_state = to_const_tegra_plane_state(plane_state);
>> +		tegra = to_tegra_plane(plane);
>> +
>> +		if (WARN_ON_ONCE(tegra->index >= TEGRA_DC_LEGACY_PLANES_NUM))
>> +			return -EINVAL;
>> +
>> +		plane_peak_bw[tegra->index] = tegra_state->peak_memory_bandwidth;
>> +		mask = tegra_plane_overlap_mask(new_state, plane_state);
>> +		overlap_mask[tegra->index] = mask;
>> +
>> +		if (hweight_long(mask) != 3)
>> +			all_planes_overlap_simultaneously = false;
>> +	}
>> +
>> +	old_state = drm_atomic_get_old_crtc_state(state, crtc);
>> +	old_dc_state = to_const_dc_state(old_state);
>> +
>> +	/*
>> +	 * Then we calculate maximum bandwidth of each plane state.
>> +	 * The bandwidth includes the plane BW + BW of the "simultaneously"
>> +	 * overlapping planes, where "simultaneously" means areas where DC
>> +	 * fetches from the planes simultaneously during of scan-out process.
>> +	 *
>> +	 * For example, if plane A overlaps with planes B and C, but B and C
>> +	 * don't overlap, then the peak bandwidth will be either in area where
>> +	 * A-and-B or A-and-C planes overlap.
>> +	 *
>> +	 * The plane_peak_bw[] contains peak memory bandwidth values of
>> +	 * each plane, this information is needed by interconnect provider
>> +	 * in order to set up latency allowness based on the peak BW, see
>> +	 * tegra_crtc_update_memory_bandwidth().
>> +	 */
>> +	for (i = 0; i < ARRAY_SIZE(plane_peak_bw); i++) {
>> +		overlap_bw = 0;
>> +
>> +		for_each_set_bit(k, &overlap_mask[i], 3) {
>> +			if (k == i)
>> +				continue;
>> +
>> +			if (all_planes_overlap_simultaneously)
>> +				overlap_bw += plane_peak_bw[k];
>> +			else
>> +				overlap_bw = max(overlap_bw, plane_peak_bw[k]);
>> +		}
>> +
>> +		new_dc_state->plane_peak_bw[i] = plane_peak_bw[i] + overlap_bw;
>> +
>> +		/*
>> +		 * If plane's peak bandwidth changed (for example plane isn't
>> +		 * overlapped anymore) and plane isn't in the atomic state,
>> +		 * then add plane to the state in order to have the bandwidth
>> +		 * updated.
>> +		 */
>> +		if (old_dc_state->plane_peak_bw[i] !=
>> +		    new_dc_state->plane_peak_bw[i]) {
>> +			plane = tegra_crtc_get_plane_by_index(crtc, i);
>> +			if (!plane)
>> +				continue;
>> +
>> +			plane_state = drm_atomic_get_plane_state(state, plane);
>> +			if (IS_ERR(plane_state))
>> +				return PTR_ERR(plane_state);
>> +		}
>> +	}
> [...]
> 
> Does it matter to which channel (plane) the peak bw is attached? Would
> it still work if the first channel specified max(peak_bw of overlaps)
> and others only zeroes?

The latency allowance will be configured incorrectly for the case of
zeroes by the memory driver, hence it does matter.

>> +	/*
>> +	 * Horizontal downscale needs a lower memory latency, which roughly
>> +	 * depends on the scaled width.  Trying to tune latency of a memory
>> +	 * client alone will likely result in a strong negative impact on
>> +	 * other memory clients, hence we will request a higher bandwidth
>> +	 * since latency depends on bandwidth.  This allows to prevent memory
>> +	 * FIFO underflows for a large plane downscales, meanwhile allowing
>> +	 * display to share bandwidth fairly with other memory clients.
>> +	 */
>> +	if (src_w > dst_w)
>> +		mul = (src_w - dst_w) * bpp / 2048 + 1;
>> +	else
>> +		mul = 1;
> [...]
> 
> One point is unexplained yet: why is the multiplier proportional to a
> *difference* between src and dst widths? Also, I would expect max (worst
> case) is pixclock * read_size when src_w/dst_w >= read_size.

IIRC, the difference gives a more adequate/practical result than the
proportion. Although, downstream driver uses proportion. I'll try to
revisit this for the next version of the patch.

> BTW, you could move this below and : if (src > dst_w) peak_bandwidth *= ...

Indeed, and should be a bit nicer to use 'mul' in both cases.
