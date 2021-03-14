Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348033A890
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 23:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCNWc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 18:32:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:16746 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhCNWcj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 18:32:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4DzDny0RN0z77;
        Sun, 14 Mar 2021 23:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1615761158; bh=JQXwq7m8NxVHxYW7SNDD+URUxbd24rpfFpPz0j8U8Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3DeB1Y7Xv+6iQ0cgCrOw6qxZ7prTdfSSNMPuC8GmUr6ov8mDJc3xByYOMHGYo4W5
         uxeBOnkyqfQXCqmfGJIOPeM1/z9taeZimerh2xyNYIlUSFD95X/KrhtTf5MX6IRJpV
         oMb1WPOiWqWU8m/TSQ+phqmbA+/BYpG7FqzkmjcbZYqDzN4jSnnqSPYjxT3sfDVCHZ
         Tm2TIG0okR9bHbs4j91kk/GRwloOvhFx8ex5UU4v/TAyuylIUpuEtWDsAl9FOF/Rgz
         Zr4jB2dmoIek9iQm004qaiRtWbkl33CHrWHu0f/f+It/4tRwVnMdIfvLiUMeez8ayu
         WLDFx2qK5mk3Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 14 Mar 2021 23:31:19 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v15 1/2] drm/tegra: dc: Support memory bandwidth
 management
Message-ID: <20210314223119.GC2733@qmqm.qmqm.pl>
References: <20210311172255.25213-1-digetx@gmail.com>
 <20210311172255.25213-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311172255.25213-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 11, 2021 at 08:22:54PM +0300, Dmitry Osipenko wrote:
> Display controller (DC) performs isochronous memory transfers, and thus,
> has a requirement for a minimum memory bandwidth that shall be fulfilled,
> otherwise framebuffer data can't be fetched fast enough and this results
> in a DC's data-FIFO underflow that follows by a visual corruption.
[...]
> +static unsigned long
> +tegra_plane_overlap_mask(struct drm_crtc_state *state,
> +			 const struct drm_plane_state *plane_state)
> +{
> +	const struct drm_plane_state *other_state;
> +	const struct tegra_plane *tegra;
> +	unsigned long overlap_mask = 0;
> +	struct drm_plane *plane;
> +	struct drm_rect rect;
> +
> +	if (!plane_state->visible || !plane_state->fb)
> +		return 0;
> +
> +	drm_atomic_crtc_state_for_each_plane_state(plane, other_state, state) {
[...]
> +	/*
> +	 * Data-prefetch FIFO will easily help to overcome temporal memory
> +	 * pressure if other plane overlaps with the cursor plane.
> +	 */
> +	if (tegra_plane_is_cursor(plane_state) && overlap_mask)
> +		return 0;
> +
> +	return overlap_mask;
> +}

Since for cursor plane this always returns 0, you could test
tegra_plane_is_cursor() at the start of the function.

> +static int tegra_crtc_calculate_memory_bandwidth(struct drm_crtc *crtc,
> +						 struct drm_atomic_state *state)
[...]
> +	/*
> +	 * For overlapping planes pixel's data is fetched for each plane at
> +	 * the same time, hence bandwidths are accumulated in this case.
> +	 * This needs to be taken into account for calculating total bandwidth
> +	 * consumed by all planes.
> +	 *
> +	 * Here we get the overlapping state of each plane, which is a
> +	 * bitmask of plane indices telling with what planes there is an
> +	 * overlap. Note that bitmask[plane] includes BIT(plane) in order
> +	 * to make further code nicer and simpler.
> +	 */
> +	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, new_state) {
> +		tegra_state = to_const_tegra_plane_state(plane_state);
> +		tegra = to_tegra_plane(plane);
> +
> +		if (WARN_ON_ONCE(tegra->index >= TEGRA_DC_LEGACY_PLANES_NUM))
> +			return -EINVAL;
> +
> +		plane_peak_bw[tegra->index] = tegra_state->peak_memory_bandwidth;
> +		mask = tegra_plane_overlap_mask(new_state, plane_state);
> +		overlap_mask[tegra->index] = mask;
> +
> +		if (hweight_long(mask) != 3)
> +			all_planes_overlap_simultaneously = false;
> +	}
> +
> +	old_state = drm_atomic_get_old_crtc_state(state, crtc);
> +	old_dc_state = to_const_dc_state(old_state);
> +
> +	/*
> +	 * Then we calculate maximum bandwidth of each plane state.
> +	 * The bandwidth includes the plane BW + BW of the "simultaneously"
> +	 * overlapping planes, where "simultaneously" means areas where DC
> +	 * fetches from the planes simultaneously during of scan-out process.
> +	 *
> +	 * For example, if plane A overlaps with planes B and C, but B and C
> +	 * don't overlap, then the peak bandwidth will be either in area where
> +	 * A-and-B or A-and-C planes overlap.
> +	 *
> +	 * The plane_peak_bw[] contains peak memory bandwidth values of
> +	 * each plane, this information is needed by interconnect provider
> +	 * in order to set up latency allowness based on the peak BW, see
> +	 * tegra_crtc_update_memory_bandwidth().
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(plane_peak_bw); i++) {
> +		overlap_bw = 0;
> +
> +		for_each_set_bit(k, &overlap_mask[i], 3) {
> +			if (k == i)
> +				continue;
> +
> +			if (all_planes_overlap_simultaneously)
> +				overlap_bw += plane_peak_bw[k];
> +			else
> +				overlap_bw = max(overlap_bw, plane_peak_bw[k]);
> +		}
> +
> +		new_dc_state->plane_peak_bw[i] = plane_peak_bw[i] + overlap_bw;
> +
> +		/*
> +		 * If plane's peak bandwidth changed (for example plane isn't
> +		 * overlapped anymore) and plane isn't in the atomic state,
> +		 * then add plane to the state in order to have the bandwidth
> +		 * updated.
> +		 */
> +		if (old_dc_state->plane_peak_bw[i] !=
> +		    new_dc_state->plane_peak_bw[i]) {
> +			plane = tegra_crtc_get_plane_by_index(crtc, i);
> +			if (!plane)
> +				continue;
> +
> +			plane_state = drm_atomic_get_plane_state(state, plane);
> +			if (IS_ERR(plane_state))
> +				return PTR_ERR(plane_state);
> +		}
> +	}
[...]

Does it matter to which channel (plane) the peak bw is attached? Would
it still work if the first channel specified max(peak_bw of overlaps)
and others only zeroes?

> +	/*
> +	 * Horizontal downscale needs a lower memory latency, which roughly
> +	 * depends on the scaled width.  Trying to tune latency of a memory
> +	 * client alone will likely result in a strong negative impact on
> +	 * other memory clients, hence we will request a higher bandwidth
> +	 * since latency depends on bandwidth.  This allows to prevent memory
> +	 * FIFO underflows for a large plane downscales, meanwhile allowing
> +	 * display to share bandwidth fairly with other memory clients.
> +	 */
> +	if (src_w > dst_w)
> +		mul = (src_w - dst_w) * bpp / 2048 + 1;
> +	else
> +		mul = 1;
[...]

One point is unexplained yet: why is the multiplier proportional to a
*difference* between src and dst widths? Also, I would expect max (worst
case) is pixclock * read_size when src_w/dst_w >= read_size.

BTW, you could move this below and : if (src > dst_w) peak_bandwidth *= ...

> +	/* average bandwidth in bytes/s */
> +	avg_bandwidth  = (bpp * src_w * src_h * mul + 7) / 8;
> +	avg_bandwidth *= drm_mode_vrefresh(&crtc_state->mode);
> +
> +	/* mode.clock in kHz, peak bandwidth in kbit/s */
> +	peak_bandwidth = crtc_state->mode.clock * bpp * mul;
[...]

Best Regards
Micha³ Miros³aw
