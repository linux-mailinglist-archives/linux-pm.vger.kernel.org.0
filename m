Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA332DC81
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 22:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhCDVqt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 16:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbhCDVqf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 16:46:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D2C06175F;
        Thu,  4 Mar 2021 13:45:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v5so226619lft.13;
        Thu, 04 Mar 2021 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XP/a7TGjJBsSgYnX2lmLJ5ngvwoGMReI4BSNcyw6ebk=;
        b=nOI46XFXRCBsSUvbRvIKRFbGspjtclGzVGrrcNy0gjoIXsNY5ILmAE7F9U/EwJSK89
         zVlFxV7Lpzo20sy3jvZYE2fxR3FzJ1t1icwJps0GDinMxkg+myufub1YrQ4srUgc9Tgj
         FJgZt75J0Z22tfaAFHQQieKIjUpFeVwcqWqnn8m8D+3TeAHxzYYIEe8bJEgF3OeanSIQ
         mhhZMJ/xfsxBXfrB+oElfttz0xHOpAocwsNrDkJqhPLpuxDIVPanLBDljzrG66L41XRp
         Hpze9TkcVcyQRWVmpgMUmdknKPeKpDD2JAD3cra0IDCkJANwUxw69TBdPB2n0WJO7ACN
         GZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XP/a7TGjJBsSgYnX2lmLJ5ngvwoGMReI4BSNcyw6ebk=;
        b=Xdv7UrfxEfyYyjWOO+s+xqyj9HExRVJtq+n6zDhSwlkSQic7yPSWQHMB7+RAI9585L
         ZRH5mH/TPs9X1zQJwsKrn5mT1u5aHwQP3R26dTTZsU5HRZBYuK1EphQFYhf3ntdqsWgQ
         aVw3IshFDWbLz0VrPmIK+kGehkXBDCV4Qog7wMcN6FYG9Dgn7Fejpx6rwuSJZbu8HTnu
         7pZ1bB9pLwRWwFxOrJBQOgJN9rxm5DIpyRTuJeIKds8UpmGTWM0l7FRvbCoZUOaFtmWI
         f2F1Z/pzOmpeFQnb7ojxwXkHmhgK3W7jQ9hZ9px0eGjFelrHbgAP0wvqp9URvy8yVTxK
         0iwQ==
X-Gm-Message-State: AOAM530+6foPo2KuxK3LkqYuoPhhjVsX0/jaIgtTA6f1qEHh9Z/WEqNE
        zBZtl4C6Bzv/gfhI17GQXYPcbuXSOEk=
X-Google-Smtp-Source: ABdhPJxa5Ga/1VP7ae9n+Gjm6IJEdSNjZCFSl4lVJSoFVNiX66SfK9IQTTFNi1oLAEsaQ49/wksTcA==
X-Received: by 2002:a05:6512:2289:: with SMTP id f9mr3612444lfu.362.1614894353207;
        Thu, 04 Mar 2021 13:45:53 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id z11sm65181lfd.98.2021.03.04.13.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 13:45:52 -0800 (PST)
Subject: Re: [PATCH v13 1/2] drm/tegra: dc: Support memory bandwidth
 management
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210302124445.29444-1-digetx@gmail.com>
 <20210302124445.29444-2-digetx@gmail.com>
 <20210303230827.GA22628@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1b352c7e-cc72-ba08-32ba-08c05cc3aa03@gmail.com>
Date:   Fri, 5 Mar 2021 00:45:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210303230827.GA22628@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.03.2021 02:08, Michał Mirosław пишет:
> On Tue, Mar 02, 2021 at 03:44:44PM +0300, Dmitry Osipenko wrote:
>> Display controller (DC) performs isochronous memory transfers, and thus,
>> has a requirement for a minimum memory bandwidth that shall be fulfilled,
>> otherwise framebuffer data can't be fetched fast enough and this results
>> in a DC's data-FIFO underflow that follows by a visual corruption.
>>
>> The Memory Controller drivers provide facility for memory bandwidth
>> management via interconnect API. Let's wire up the interconnect API
>> support to the DC driver in order to fix the distorted display output
>> on T30 Ouya, T124 TK1 and other Tegra devices.
> 
> I did a read on the code. I have put some thoughts and nits inbetween the
> diff, but here are more general questions about the patch:

Hello, Michał! Thank you very much for taking a look at the patch!

> Is there a reason why the bandwidth is allocated per plane instead of just
> using one peak and average for the whole configuration? Or is there a need
> to expose all the planes as interconnect channels and allocate their
> bandwidth individually?

Each display plane has individual memory client on Tegra, memory ICC
paths are specified per memory client. This is how memory ICCs are
defined in the DT binding and that's what memory drivers are expecting
to deal with. It is also nice to see in ICC debugfs how much memory
bandwidth is consumed by each individual memory client.

> From algorithmic part I see that the plane overlaps are calculated twice
> (A vs B and later B vs A). The cursor plane is ignored, but nevertheless
> its overlap mask is calculated before being thrown away.

The algorithm assumes that we have a fixed number of planes to care
about and it's not executed in a hot code path, hence it's more optimal
to have a simpler and smaller code rather than try to optimize it
without gaining any benefits, IMO.

> The bandwidths
> are also calculated twice: once for pre-commit and then again for
> post-commit.  Is setting bandwidth for an interconnect expensive when
> re-setting a value that was already set? The code seems to avoid this
> case, but maybe unnecessarily?

The CCF discards dummy rate-changes in the end of ICC code path.
Besides, we're not performing it in a hot code paths, hence performance
isn't a concern in this patch.

The tegra_crtc_update_memory_bandwidth() relies on being called before
and after the atomic commit. For example CRTC's "active" state is
updated only after the completion of commit-tail phase.

Earlier versions of this patch had checks that tried to avoid setting
bandwidth in both 'begin' and 'end' phases of a commit, but then I found
that it was buggy in regards to DPMS handling and it was much more
optimal to remove the unnecessary "optimizations" since code was blowing
up in complexity when I tried to fix it.

The tegra_crtc_update_memory_bandwidth() still checks whether old BW =
new BW, hence in practice actual ICC changes are only performed when
plane is turned on/off.

> [...cut the big and interesting part...]
> 
> [...]
>> @@ -65,7 +75,9 @@ struct tegra_dc_soc_info {
>>  	unsigned int num_overlay_formats;
>>  	const u64 *modifiers;
>>  	bool has_win_a_without_filters;
>> +	bool has_win_b_vfilter_mem_client;
>>  	bool has_win_c_without_vert_filter;
>> +	unsigned int plane_tiled_memory_bandwidth_x2;
> 
> This looks more like bool in the code using it.

Good catch, thank you!

> [...]
>> --- a/drivers/gpu/drm/tegra/plane.c
>> +++ b/drivers/gpu/drm/tegra/plane.c
> [...]
>> +static int tegra_plane_check_memory_bandwidth(struct drm_plane_state *state)
> 
> The function's body looks more like 'update' or 'recalculate' rather
> than 'check' the memory bandwidth.

The 'check' in the name is intended to show that function belongs to
atomic-state checking.

But tegra_plane_calculate_memory_bandwidth_state() also is a good
variant. I'll consider the renaming, thanks!

>> +	struct tegra_plane_state *tegra_state = to_tegra_plane_state(state);
>> +	unsigned int i, bpp, bpp_plane, dst_w, src_w, src_h, mul;
>> +	const struct tegra_dc_soc_info *soc;
>> +	const struct drm_format_info *fmt;
>> +	struct drm_crtc_state *crtc_state;
>> +	u32 avg_bandwidth, peak_bandwidth;
>> +
>> +	if (!state->visible)
>> +		return 0;
>> +
>> +	crtc_state = drm_atomic_get_new_crtc_state(state->state, state->crtc);
>> +	if (!crtc_state)
>> +		return -EINVAL;
>> +
>> +	src_w = drm_rect_width(&state->src) >> 16;
>> +	src_h = drm_rect_height(&state->src) >> 16;
>> +	dst_w = drm_rect_width(&state->dst);
>> +
>> +	fmt = state->fb->format;
>> +	soc = to_tegra_dc(state->crtc)->soc;
>> +
>> +	/*
>> +	 * Note that real memory bandwidth vary depending on format and
>> +	 * memory layout, we are not taking that into account because small
>> +	 * estimation error isn't important since bandwidth is rounded up
>> +	 * anyway.
>> +	 */
>> +	for (i = 0, bpp = 0; i < fmt->num_planes; i++) {
>> +		bpp_plane = fmt->cpp[i] * 8;
> 
> Nit: you could declare the bpp_plane here.
> 
>> +		/*
>> +		 * Sub-sampling is relevant for chroma planes only and vertical
>> +		 * readouts are not cached, hence only horizontal sub-sampling
>> +		 * matters.
>> +		 */
>> +		if (i > 0)
>> +			bpp_plane /= fmt->hsub;
>> +
>> +		bpp += bpp_plane;
>> +	}
>> +
>> +	/*
>> +	 * Horizontal downscale takes extra bandwidth which roughly depends
>> +	 * on the scaled width.
>> +	 */
>> +	if (src_w > dst_w)
>> +		mul = (src_w - dst_w) * bpp / 2048 + 1;
>> +	else
>> +		mul = 1;
> 
> Does it really need more bandwidth to scale down? Does it read the same
> data multiple times just to throw it away?

The hardware isn't optimized for downscale, it indeed takes more
bandwidth. You'll witness a severe underflow of plane's memory FIFO
buffer on trying to downscale 1080p plane to 50x50. It's more optimal to
make a 2d blit to intermediate framebuffer for a large downscales.

>> +	/* average bandwidth in bytes/s */
>> +	avg_bandwidth  = src_w * src_h * bpp / 8 * mul;
>> +	avg_bandwidth *= drm_mode_vrefresh(&crtc_state->mode);
>> +
>> +	/* mode.clock in kHz, peak bandwidth in kbit/s */
>> +	peak_bandwidth = crtc_state->mode.clock * bpp * mul;
> 
> I would guess that (src_w * bpp / 8) needs rounding up unless the plane
> is continuous. Or you could just add the max rounding error here and
> get a safe overestimated value. Maybe this would be better done when
> summing per-plane widths.

Looks like indeed it should be good to add a round-up, thanks.

>> +	/* ICC bandwidth in kbyte/s */
>> +	peak_bandwidth = kbps_to_icc(peak_bandwidth);
>> +	avg_bandwidth  = Bps_to_icc(avg_bandwidth);
> 
> This could be merged with the assignments after the following 'if' block.

Seem so, thanks.

>> +	/*
>> +	 * Tegra30/114 Memory Controller can't interleave DC memory requests
>> +	 * and DC uses 16-bytes atom for the tiled windows, while DDR3 uses 32
>> +	 * bytes atom. Hence there is x2 memory overfetch for tiled framebuffer
>> +	 * and DDR3 on older SoCs.
>> +	 */
>> +	if (soc->plane_tiled_memory_bandwidth_x2 &&
>> +	    tegra_state->tiling.mode == TEGRA_BO_TILING_MODE_TILED) {
>> +		peak_bandwidth *= 2;
>> +		avg_bandwidth *= 2;
>> +	}
>> +
>> +	tegra_state->peak_memory_bandwidth = peak_bandwidth;
>> +	tegra_state->avg_memory_bandwidth = avg_bandwidth;
>> +
>> +	return 0;
>> +}
> 
> [...]
>> +static const char * const tegra_plane_icc_names[] = {
>> +	"wina", "winb", "winc", "", "", "", "cursor",
>> +};
>> +
>> +int tegra_plane_interconnect_init(struct tegra_plane *plane)
>> +{
>> +	const char *icc_name = tegra_plane_icc_names[plane->index];
> 
> Is plane->index guaranteed to be <= 6? I would guess so, but maybe
> BUILD_BUG_ON(sizeof(icc_names)==TEGRA_DC_LEGACY_PLANES_NUM) or some
> other check could document this?

The maximum index should always stay 6 for older h/w. It should be fine
to add extra sanity check to prevent an explicit misuse of the function,
just in a case. Thank you for the suggestion.
