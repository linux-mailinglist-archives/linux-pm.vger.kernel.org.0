Return-Path: <linux-pm+bounces-18979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA069EC28E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 03:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF76418890D0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 02:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA51A9B42;
	Wed, 11 Dec 2024 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZO8zNfFT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AC2451F9;
	Wed, 11 Dec 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885675; cv=none; b=GtxfeuGplGA1gxKUBogjgTGeNEL3yuhrTj2Y0xhMGOYNIxhLnz/TK/SfED5eh0nxQXUK8Rocfg2gzTKKC17sj0UxOaZlTYLlKYVq2i9kXHzuzxi/5dh7xPQ/cQ0MQBrOUAnmBTfUW6SS6iSzy7fSd1TdGJ2ysIfnZBmJxE3uE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885675; c=relaxed/simple;
	bh=9GSTezhvg6352Xf2fBHpeDvQbc4a4Rbg6MRnpzOAIvA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bbegUI9ZVmWaCkEumMKnAidQ3n9MTFkzx2sxqQjDs0mpGR5Rn4SItLWVVE9zQ8LDmApkJDcZ1urEQ8/ZQfZ7q8r6hGqMYc0SfGE9sBRTQRE63u1n/DXwR9XtQy7mpTmBZ0JzPWd/zpVzW/cKJ3KcysKEYC0EKhTFaWyEzW1dF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZO8zNfFT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733885663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1mx7XJOCZkqOCUMCxhvevt017R9j4FbeUmXeUiyYms=;
	b=ZO8zNfFTykNreqEzIRyE5Ap7GtT0s2YdYkUvSOpbnDysUwZoFWMP6yDRD/JFgoab5aMsea
	x2lQX2y+B1TJZqbfm+HGF71Oj6ZHAdWcZ03tPBqlnWvdtY7FP9fCbtfcK62bjP6c3Teg7e
	6UE94FgCXY0JAMKrMcAPFWawnnxZP46b84BgfJ1K6HFMMB/ZvVZBYl0vWxCn5TYs9CK1fR
	mqfhQlClJrB4XDrB3a0GvH7lK8/rQJ3gWfAUrTaS2AX5JnFkKO9S6uQWWLT3L8sjB09Ahr
	w2jv/Wi02GxnpYhtQlOKd0lvpn1d/sTJIxyfF+iLLESO49TVxb35S5pgbhVB8w==
Date: Wed, 11 Dec 2024 03:54:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Caesar Wang <wxt@rock-chips.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, Finley Xiao
 <finley.xiao@rock-chips.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Kevin Hilman <khilman@linaro.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/6] pmdomain: rockchip: fix rockchip_pd_power error
 handling
In-Reply-To: <CAMdYzYqmn0UktNfz7L352zcjgmxf4tsRs2fwiFXF7NbfPY4zSg@mail.gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-2-pgwipeout@gmail.com>
 <1b323d6e9ef873bfc770e9d54b7a3a64@manjaro.org>
 <CAMdYzYqmn0UktNfz7L352zcjgmxf4tsRs2fwiFXF7NbfPY4zSg@mail.gmail.com>
Message-ID: <821c348ef4b8e199e662d6a49430d1e7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-10 21:12, Peter Geis wrote:
> On Tue, Dec 10, 2024 at 3:18 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-12-10 02:30, Peter Geis wrote:
>> > The calls rockchip_pd_power makes to rockchip_pmu_set_idle_request lack
>> > any return error handling, causing device drivers to incorrectly
>> > believe
>> > the hardware idle requests succeed when they may have failed. This
>> > leads
>> > to software possibly accessing hardware that is powered off and the
>> > subsequent SError panic that follows.
>> >
>> > Add error checking and return errors to the calling function to prevent
>> > such crashes.
>> >
>> > gst-launch-1.0 videotestsrc num-buffers=2000 ! v4l2jpegenc ! fakesink
>> > Setting pipeline to PAUSED ...er-x64
>> > Pipeline is PREROLLING ...
>> > Redistribute latency...
>> > rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack
>> > on
>> > domain 'hevc', val=0x98260, idle = 0
>> > SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
>> > CPU: 2 UID: 0 PID: 804 Comm: videotestsrc0:s Not tainted 6.12.0-rc5+
>> > #54
>> > Hardware name: Firefly roc-rk3328-cc (DT)
>> > pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> > pc : rockchip_vpu2_jpeg_enc_run+0x168/0xbc8
>> > lr : device_run+0xb0/0x128
>> > sp : ffff800082143a20
>> > x29: ffff800082143a20 x28: 0000000000000140 x27: 0000000000000000
>> > x26: ffff582c47a313e8 x25: ffff582c53e95000 x24: ffff582c53e92800
>> > x23: ffff582c5bbe0000 x22: 0000000000000000 x21: ffff582c47a31080
>> > x20: ffffa0d78cfa4168 x19: ffffa0d78cfa4168 x18: ffffb755b0519000
>> > x17: 000000040044ffff x16: 00500072b5503510 x15: a7a6a5a4a3a29a99
>> > x14: 989796959493928a x13: 0000000051eb851f x12: 00000000000000ff
>> > x11: ffffa0d78d812880 x10: ffffa0d78d7fbca0 x9 : 000000000000003f
>> > x8 : 0000000000000063 x7 : 000000000000003f x6 : 0000000000000040
>> > x5 : ffff80008010d000 x4 : ffffa0d78cfa4168 x3 : ffffa0d78cfbfdd8
>> > x2 : ffff80008010d0f4 x1 : 0000000000000020 x0 : 0000000000000140
>> > Kernel panic - not syncing: Asynchronous SError Interrupt
>> > CPU: 2 UID: 0 PID: 804 Comm: videotestsrc0:s Not tainted 6.12.0-rc5+
>> > #54
>> > Hardware name: Firefly roc-rk3328-cc (DT)
>> > Call trace:
>> > dump_backtrace+0xa0/0x128
>> > show_stack+0x20/0x38
>> > dump_stack_lvl+0xc8/0xf8
>> > dump_stack+0x18/0x28
>> > panic+0x3ec/0x428
>> > nmi_panic+0x48/0xa0
>> > arm64_serror_panic+0x6c/0x88
>> > do_serror+0x30/0x70
>> > el1h_64_error_handler+0x38/0x60
>> > el1h_64_error+0x7c/0x80
>> > rockchip_vpu2_jpeg_enc_run+0x168/0xbc8
>> > device_run+0xb0/0x128
>> > v4l2_m2m_try_run+0xac/0x230
>> > v4l2_m2m_ioctl_streamon+0x70/0x90
>> > v4l_streamon+0x2c/0x40
>> > __video_do_ioctl+0x194/0x400
>> > video_usercopy+0x10c/0x808
>> > video_ioctl2+0x20/0x80
>> > v4l2_ioctl+0x48/0x70
>> > __arm64_sys_ioctl+0xb0/0x100
>> > invoke_syscall+0x50/0x120
>> > el0_svc_common.constprop.0+0x48/0xf0
>> > do_el0_svc+0x24/0x38
>> > el0_svc+0x38/0x100
>> > el0t_64_sync_handler+0xc0/0xc8
>> > el0t_64_sync+0x1a8/0x1b0
>> > SMP: stopping secondary CPUs
>> > Kernel Offset: 0x20d70c000000 from 0xffff800080000000
>> > PHYS_OFFSET: 0xffffa7d3c0000000
>> > CPU features: 0x00,00000090,00200000,0200421b
>> > Memory Limit: none
>> > ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
>> >
>> > Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain
>> > driver")
>> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>> 
>> This patch is obviously correct, because not checking what
>> rockchip_pmu_set_idle_request() returns was simply wrong.
>> Thanks for the patch!
>> 
>> Though, shouldn't we improve further the way proper error
>> handling is performed in rockchip_do_pmu_set_power_domain(),
>> by "rolling back" what rockchip_do_pmu_set_power_domain()
>> did after powering up fails?
> 
> Eventually, but the reality is if we hit this path the hardware is
> already broken. I wanted to provide a fix with the least amount of
> risk of breaking things further. I'm open to suggestions for further
> improvements here.

Perhaps a good approach, at the moment, would be to add no more
code for the "rollback", but to add a TODO note about the need for
that addition.  That way we'd keep the amount of changes at the
minimum, to hopefully not cause any regressions, while leaving
a note for the second round of improvements in the future.

> Current behavior with this patch with the example above causes
> gstreamer to wait indefinitely. I'll trace the return path and see if
> returning an error other than -ETIMEDOUT triggers more robust
> handling.

Sounds like a plan to me.  Thanks for working on this!

>> 
>> > ---
>> >
>> >  drivers/pmdomain/rockchip/pm-domains.c | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/pmdomain/rockchip/pm-domains.c
>> > b/drivers/pmdomain/rockchip/pm-domains.c
>> > index cb0f93800138..57e8fa25d2bd 100644
>> > --- a/drivers/pmdomain/rockchip/pm-domains.c
>> > +++ b/drivers/pmdomain/rockchip/pm-domains.c
>> > @@ -590,14 +590,18 @@ static int rockchip_pd_power(struct
>> > rockchip_pm_domain *pd, bool power_on)
>> >                       rockchip_pmu_save_qos(pd);
>> >
>> >                       /* if powering down, idle request to NIU first */
>> > -                     rockchip_pmu_set_idle_request(pd, true);
>> > +                     ret = rockchip_pmu_set_idle_request(pd, true);
>> > +                     if (ret < 0)
>> > +                             return ret;
>> >               }
>> >
>> >               rockchip_do_pmu_set_power_domain(pd, power_on);
>> >
>> >               if (power_on) {
>> >                       /* if powering up, leave idle mode */
>> > -                     rockchip_pmu_set_idle_request(pd, false);
>> > +                     ret = rockchip_pmu_set_idle_request(pd, false);
>> > +                     if (ret < 0)
>> > +                             return ret;
>> >
>> >                       rockchip_pmu_restore_qos(pd);
>> >               }

