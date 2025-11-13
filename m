Return-Path: <linux-pm+bounces-37935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0FBC57048
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7EE94ED0F2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7366B334C17;
	Thu, 13 Nov 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckP5VQnG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2D2E1747;
	Thu, 13 Nov 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030831; cv=none; b=t6J4T43HLwLY3PL9lVVYiR4qtXQ/YgdhyPYg/TcIgr+WNZNyxi+T3Bqku3cZmrUV6hq4+5+ud35OdEzdgeezXztcvOyIjhQZWLaICotvyQehvLR9GAXbtuTNFqrMoKVcTjtyL6Co45V7OR05h6Cg1z8OWhR3SRuYexaimeaz9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030831; c=relaxed/simple;
	bh=OgINiLjgAd2k62v4P1vRAd4BRMmh+qFhg8M64VJJkDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXlWbHKmj6p8Z3WzUI2+wVtPlRjuCqMPI/BdDAXWLUMhYv3GFtnaB9Pwx7ymL3zWJVMgZz8LDeMpYavyiHBpNV08sp2JpMkl5j0UNmsZNvHfwR9QifdTUl7mEumDS8VQDzRNNkRedQeaSNckZc+0/caAieN4Uqd0AjgK17YIpWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckP5VQnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF7AC4CEF1;
	Thu, 13 Nov 2025 10:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763030830;
	bh=OgINiLjgAd2k62v4P1vRAd4BRMmh+qFhg8M64VJJkDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckP5VQnGzzZfaC+xj1cZu/WmVacERZE2VJl9f3lVwmhswbyuod9s0qLNB9JTYfNUo
	 EDk6aGtbnJPwUcagT8LFNKQCCEV3BJG4bH8KFgeS4zIiJrvT5fArif/gWUCG0RKZRS
	 J77zYdtHIM4Q/D7ae9K3z4eRmnDcIIb2J1lzK1fRIR8N+XU8ZuFGpF01UnlTEfn2eh
	 SEe7D25qsHGu5LFrIYYQSH4JpW7/cH2t2dJollhV+5MnwlnGruzt4PKmU3xYJ0K1Zd
	 J9Xah0SFVJRJWsnY1DofMb5hgcIW/5wVBPtuU9QWjDeToJ7amcJV3WVeaU2X4/J9Yk
	 pGWj4qQ8Wu4XA==
Date: Thu, 13 Nov 2025 11:47:06 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] HID: input: Introduce struct hid_battery
Message-ID: <tuya626zqiabd6ejwbaafj4cq3nlngc2vzvvjwdl3rc5wkwhhh@2k6ehu62tviu>
References: <20251113001508.713574-1-lzampier@redhat.com>
 <20251113001508.713574-2-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113001508.713574-2-lzampier@redhat.com>

On Nov 13 2025, Lucas Zampieri wrote:
> Add struct hid_battery to encapsulate battery state per HID device.
> This structure will allow tracking individual battery properties
> including capacity, min/max values, report information, and status.
> 
> The structure includes a list node to enable support for multiple
> batteries per device in subsequent patches.
> 
> This is a preparation step for transitioning from direct power_supply
> access to a more flexible battery management system.
> 
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  include/linux/hid.h | 30 ++++++++++++++++++++++++++++++

I know Bastien asked you to split out this into a separate commit, but I
hate having a header change when noone uses it. It is painful for people
needing to backport the further changes (imagine you are fixing a CVE
without noticing it), as they also need to pull this one.

>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index a4ddb94e3ee5..63422130de20 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -634,6 +634,36 @@ enum hid_battery_status {
>  	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
>  };
>  
> +/**
> + * struct hid_battery - represents a single battery power supply
> + * @list: list node for linking into hid_device's battery list

For the first inclusion of the new struct, please drop the list field.
This should go into the last patch when you actually make use of it.

> + * @dev: pointer to the parent hid_device
> + * @ps: the power supply device
> + * @capacity: current battery capacity
> + * @min: minimum battery value
> + * @max: maximum battery value
> + * @report_type: type of report (HID_INPUT_REPORT, HID_FEATURE_REPORT)
> + * @report_id: report ID for this battery
> + * @charge_status: current charge status
> + * @status: battery status (unknown, queried, reported)
> + * @avoid_query: if true, don't query battery (wait for device reports)
> + * @ratelimit_time: time for rate limiting battery updates
> + */
> +struct hid_battery {
> +	struct list_head list;
> +	struct hid_device *dev;
> +	struct power_supply *ps;
> +	__s32 capacity;
> +	__s32 min;
> +	__s32 max;
> +	__s32 report_type;
> +	__s32 report_id;
> +	__s32 charge_status;
> +	enum hid_battery_status status;
> +	bool avoid_query;
> +	ktime_t ratelimit_time;
> +};
> +
>  struct hid_driver;
>  struct hid_ll_driver;
>  
> -- 
> 2.51.1
> 

Cheers,
Benjamin

