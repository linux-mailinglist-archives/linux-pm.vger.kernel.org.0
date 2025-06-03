Return-Path: <linux-pm+bounces-28011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87345ACC63A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C7616D1CD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C522B8A9;
	Tue,  3 Jun 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clwD//bz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7812B2CF;
	Tue,  3 Jun 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952907; cv=none; b=jwEkqh/yB6EPy3IZveIsM28Q9/QLXrt+AbVyp5DlVxnrf93aV0wOTbSerX/43vazRC+hzPJ4WkBZCRICEqPVFhKsONdpswQgELo4pStvmrmtNFrkeR8IH150Bkz9PfGATGs1hOWeN5+YidkRrdHudoqdzm7pAC1IrcZ0jnLVkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952907; c=relaxed/simple;
	bh=yWLllLUpOEyVCGkMXN8a0AVq3PmOpM46q4DNS+nAzsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFhDG3bjBZT/l6ittrEmgqOM/zFXGacfPxebharZ6ESjQPOSDBQ0zhcJWovdj4jSdUvcXyAdvI/LjqVJyREjF79i4C3OemCufEnumpCsB3wRpklQa8sAx0vH/tuBcmuyV9vxSj7f9HcPipO3ulpL1OdTFAh7aBZPAejk9mDTsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clwD//bz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450dd065828so27004655e9.2;
        Tue, 03 Jun 2025 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748952893; x=1749557693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBtHq9bEMJBvgQUcmgLACpIW+OmIQWGP0/+EXyyU5WQ=;
        b=clwD//bzzs6pZbk3N1cYi22EfejQ5qfLh/p6JjWuYsBoh6lrtdMHKjB/xv14IELMUd
         HDGDDjjYT1lvYpuRfIf0AdU++8hmpEGEByuciuURCiLV/hYMxGu9VXsLTFCbYpAH2K1O
         tufBLGMzL0fpsGIwhptVt5zvAlsnrq8q/XRS+PfK5+X7qFc8NsF3A3QiDaI4SAZwYqVT
         WjexwdAZ4qspIb2oQt3VRxL1l6fiVv33uPyX2mUxrNiwXlCqXoRXFziH+6n+RWzmm+u1
         huoR/5WA1EF1u0y5KLdl0L4EnN9+P5B8Yjqtf9UVieUKd1C9DWtvjv7qjeks9pzBz/+D
         WmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748952893; x=1749557693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBtHq9bEMJBvgQUcmgLACpIW+OmIQWGP0/+EXyyU5WQ=;
        b=d6B8MBQ8lrUCDr+XRA2HRiIJIqdH8iHSQ9le/xPpm9l5TIy81yNJrp4mbXnEBevx2L
         KiplQpc2veFG0e+PFWzPj3clXZDotQzMboqwAglo/qSD6sZFCBzkaoh5RAFLhq90rMZ2
         f+W3jfx9W5VR4Ded8cHxks8jCLH8yqzXLGdRkxVRqPA3foBxn1XGP+3T4L++3iDT1fwQ
         1S+ewPmW7W8ppctDmWz7OptwEJkI3b8pDUwxcBP5jYm4kpo2twunRcLV53kHtXl0Toig
         xxZ5pjEfQOZ9eKZDMmS2aRxMezxe43Mz59eVx2g+db4BPGNfHVoiiToU9g8AGswkm+WH
         Y8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWsrwKcKUmYwlCO9mi+w59VhnqcVM/SMO5TcGmZlbQUQsfFlNh5Ou+cDkxs60rTRwAaFtSQpOf9+tg=@vger.kernel.org, AJvYcCXtvIPO74YhJUsZ7OCXfQn7FqOwnTd5dzHkWEN9yBW5KSU3WzvPEpCXSOjc4AWwkmS4C/eBzzRZoC17t9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS03+yJD8eVvzGVw8zbwJWioUHF8rv+ralNqV3ur4t+/CBb2Jv
	47nOFUeCrax/GGg56J0fkX+zphxhr0l2O30BOndnVo4xsgRuzqUhGZ6l
X-Gm-Gg: ASbGncuKLi4wEH6U4rDSerWLl0EQybzkFSBfNtj4wMLe6FKSS4LmNC83lj691Ap43iv
	hbeCH2JXgbujHq3bq+VuDJ0tw1ioaptLDf3+qyTijrNv4futBSw1zRTweLcjrQVgKc1QamO0Xpd
	EmPY/1tY1RuiPQkVm025fKnLgo/7RFqSfEg1P5DaYxKzDR1PN4dFsYOShxJ/7/njBYMsYAgnrIH
	4XOtpNWVT8ofmVTmhwBEmurVHGWZbDydwAQVdrd/OMY8vLCfIk70w1Xyc8ndepADs50VKyDPFSH
	ZjJEvSzHTk3xk5yWg2XFUT/7gRGAG2ns5a2R/8V9q+zfzh1wVG31U/RnC+AcTuov
X-Google-Smtp-Source: AGHT+IFLIddZ1n9BiF3+RsinulHdH1ITBrEWFVcefFhsANtUA6mBWqQV029+V+e8westvSP355GGmA==
X-Received: by 2002:a05:600c:22d2:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-450d880abaamr119131925e9.4.1748952892007;
        Tue, 03 Jun 2025 05:14:52 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:eaf:3101:2d68:caee:7294:3fe1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009fd7csm17990789f8f.88.2025.06.03.05.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 05:14:51 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:14:48 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Saravana Kannan <saravanak@google.com>,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending
 children
Message-ID: <aD7nOMP3xA9BR781@debian.local>
References: <aD2U3VIhf8vDkl09@debian.local>
 <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org>
 <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local>
 <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>

On Tue, Jun 03, 2025 at 01:39:01PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 3, 2025 at 1:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jun 3, 2025 at 12:30 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Jun 3, 2025 at 12:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 3, 2025 at 12:17 PM Chris Bainbridge
> > > > <chris.bainbridge@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jun 03, 2025 at 11:38:37AM +0200, Rafael J. Wysocki wrote:
> > > > > >
> > > > > > Chris, please check if the attached patch helps.  I'm going to post it
> > > > > > as a fix anyway later today, but it would be good to verify that it is
> > > > > > sufficient.
> > > > >
> > > > > This did not fix my test case, pstore crash log was:
> > > >
> > > > OK, so can you please enable PM debug messages:
> > > >
> > > > # echo 1 > /sys/power/pm_debug/messages
> > >
> > > This should be
> > >
> > > # echo 1 > /sys/power/pm_debug_messages
> > >
> > > sorry.
> > >
> > > > and enabled dynamic debug in drivers/base/power/main.c:
> > > >
> > > > # echo "file drivers/base/power/main.c +p" > /proc/dynamic_debug/control
> > > >
> > > > repeat the test and capture the log?
> >
> > Actually, no need to do this, there is an obvious bug:
> > list_splice_init() should be used instead of list_splice() when the
> > emptied list is going to be used again.  Ugh.
> >
> > Please check if the attached patch along with the previous one makes
> > the issue go away entirely.
> 
> Really attached this time, sorry.

> ---
>  drivers/base/power/main.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1458,7 +1458,7 @@
>  			 * Move all devices to the target list to resume them
>  			 * properly.
>  			 */
> -			list_splice(&dpm_late_early_list, &dpm_noirq_list);
> +			list_splice_init(&dpm_late_early_list, &dpm_noirq_list);
>  			break;
>  		}
>  	}
> @@ -1660,7 +1660,7 @@
>  			 * Move all devices to the target list to resume them
>  			 * properly.
>  			 */
> -			list_splice(&dpm_suspended_list, &dpm_late_early_list);
> +			list_splice_init(&dpm_suspended_list, &dpm_late_early_list);
>  			break;
>  		}
>  	}
> @@ -1953,7 +1953,7 @@
>  			 * Move all devices to the target list to resume them
>  			 * properly.
>  			 */
> -			list_splice(&dpm_prepared_list, &dpm_suspended_list);
> +			list_splice_init(&dpm_prepared_list, &dpm_suspended_list);
>  			break;
>  		}
>  	}

This patch does fix the list corruption, but the "Unbalanced
pm_runtime_enable" still occurs:

[  402.894024] PM: suspend entry (s2idle)
[  403.035176] Filesystems sync: 0.141 seconds
[  403.038710] Freezing user space processes
[  403.041950] Freezing user space processes completed (elapsed 0.003 seconds)
[  403.041991] OOM killer disabled.
[  403.041994] Freezing remaining freezable tasks
[  403.043386] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  403.043533] printk: Suspending console(s) (use no_console_suspend to debug)
[  403.300363] snd_hda_codec_hdmi hdaudioC0D0: PM: direct-complete suspend driver flags: 0
[  403.300388] dummy 3-0037: PM: direct-complete suspend driver flags: 0
[  403.300419] dummy 3-0036: PM: direct-complete suspend driver flags: 0
[  403.300450] scsi_device 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  403.300480] scsi_host host0: PM: direct-complete suspend driver flags: 0
[  403.300493]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.300525]  ep_82: PM: direct-complete suspend driver flags: 0
[  403.300556]  ep_01: PM: direct-complete suspend driver flags: 0
[  403.300574] i2c i2c-8: PM: direct-complete suspend driver flags: 0
[  403.300590] i2c i2c-7: PM: direct-complete suspend driver flags: 0
[  403.300607] i2c i2c-6: PM: direct-complete suspend driver flags: 0
[  403.300623] i2c i2c-5: PM: direct-complete suspend driver flags: 0
[  403.300640] i2c i2c-4: PM: direct-complete suspend driver flags: 0
[  403.300656]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.301227]  ep_04: PM: direct-complete suspend driver flags: 0
[  403.301730] net lo: PM: direct-complete suspend driver flags: 0
[  403.301906]  ep_84: PM: direct-complete suspend driver flags: 0
[  403.301909]  ep_03: PM: direct-complete suspend driver flags: 0
[  403.301910]  ep_83: PM: direct-complete suspend driver flags: 0
[  403.301913]  ep_02: PM: direct-complete suspend driver flags: 0
[  403.301918]  ep_82: PM: direct-complete suspend driver flags: 0
[  403.301921]  ep_01: PM: direct-complete suspend driver flags: 0
[  403.301926]  ep_81: PM: direct-complete suspend driver flags: 0
[  403.301928]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.301929]  ep_83: PM: direct-complete suspend driver flags: 0
[  403.301929]  ep_03: PM: direct-complete suspend driver flags: 0
[  403.301932]  ep_82: PM: direct-complete suspend driver flags: 0
[  403.301932]  ep_02: PM: direct-complete suspend driver flags: 0
[  403.301933]  ep_81: PM: direct-complete suspend driver flags: 0
[  403.301937]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.301940] uvcvideo 1-3:1.1: PM: direct-complete suspend driver flags: 0
[  403.301943]  ep_87: PM: direct-complete suspend driver flags: 0
[  403.301944]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.301944]  ep_81: PM: direct-complete suspend driver flags: 0
[  403.301946]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.301947]  ep_81: PM: direct-complete suspend driver flags: 0
[  403.301954]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.301955]  ep_81: PM: direct-complete suspend driver flags: 0
[  403.301957] bdi 0:64: PM: direct-complete suspend driver flags: 0
[  403.301960]  ep_00: PM: direct-complete suspend driver flags: 0
[  403.301963]  ep_81: PM: direct-complete suspend driver flags: 0
[  403.301971] i2c i2c-2: PM: direct-complete suspend driver flags: 0
[  403.301972] i2c i2c-1: PM: direct-complete suspend driver flags: 0
[  403.301972] pcie_bwctrl 0000:00:08.1:pcie010: PM: direct-complete suspend driver flags: 0
[  403.301973] pcie_pme 0000:00:08.1:pcie001: PM: direct-complete suspend driver flags: 0
[  403.301974] pcie_bwctrl 0000:00:02.4:pcie010: PM: direct-complete suspend driver flags: 0
[  403.301976] pcie_pme 0000:00:02.4:pcie001: PM: direct-complete suspend driver flags: 0
[  403.301978] pcie_bwctrl 0000:00:02.2:pcie010: PM: direct-complete suspend driver flags: 0
[  403.301982] pcie_pme 0000:00:02.2:pcie001: PM: direct-complete suspend driver flags: 0
[  403.301982] pcie_mp2_amd 0000:03:00.7: PM: bus suspend driver flags: 0
[  403.301983] ccp 0000:03:00.2: PM: bus suspend driver flags: 0
[  403.301985] pci 0000:00:18.7: PM: bus suspend driver flags: 0
[  403.301985] pci 0000:00:18.6: PM: bus suspend driver flags: 0
[  403.301987] pci 0000:00:18.5: PM: bus suspend driver flags: 0
[  403.301987] pci 0000:00:18.4: PM: bus suspend driver flags: 0
[  403.301988] pci 0000:00:18.2: PM: bus suspend driver flags: 0
[  403.301990] pci 0000:00:18.1: PM: bus suspend driver flags: 0
[  403.301991] pci 0000:00:18.0: PM: bus suspend driver flags: 0
[  403.301993] pci 0000:00:08.0: PM: bus suspend driver flags: 0
[  403.301995] pci 0000:00:02.0: PM: bus suspend driver flags: 0
[  403.301996] pci 0000:00:01.0: PM: bus suspend driver flags: 0
[  403.302040] sound seq: PM: direct-complete suspend driver flags: 0
[  403.302041] pci 0000:00:00.0: PM: bus suspend driver flags: 0
[  403.302049] net br-bd31abe76a1b: PM: direct-complete suspend driver flags: 0
[  403.302054] btusb 3-3:1.1: PM: direct-complete suspend driver flags: 0
[  403.302054] net lo: PM: direct-complete suspend driver flags: 0
[  403.302056] usb 1-4:1.0: PM: direct-complete suspend driver flags: 0
[  403.302306] net docker0: PM: direct-complete suspend driver flags: 0
[  403.302313] ptp ptp0: PM: direct-complete suspend driver flags: 0
[  403.302321]  port0.0: PM: direct-complete suspend driver flags: 0
[  403.302326]  4:variable_supply: PM: direct-complete suspend driver flags: 0
[  403.302332]  3:fixed_supply: PM: direct-complete suspend driver flags: 0
[  403.302339]  2:fixed_supply: PM: direct-complete suspend driver flags: 0
[  403.302343] usb 1-4: PM: type suspend driver flags: 0
[  403.302345]  1:fixed_supply: PM: direct-complete suspend driver flags: 0
[  403.302351]  sink-capabilities: PM: direct-complete suspend driver flags: 0
[  403.302355]  1:fixed_supply: PM: direct-complete suspend driver flags: 0
[  403.302358]  source-capabilities: PM: direct-complete suspend driver flags: 0
[  403.302364] vc vcsa6: PM: direct-complete suspend driver flags: 0
[  403.302366] usb usb2: PM: type suspend driver flags: 0
[  403.302370] vc vcsu6: PM: direct-complete suspend driver flags: 0
[  403.302377] vc vcs6: PM: direct-complete suspend driver flags: 0
[  403.302381] vc vcsa5: PM: direct-complete suspend driver flags: 0
[  403.302385] vc vcsu5: PM: direct-complete suspend driver flags: 0
[  403.302389] vc vcs5: PM: direct-complete suspend driver flags: 0
[  403.302393] vc vcsa4: PM: direct-complete suspend driver flags: 0
[  403.302397] vc vcsu4: PM: direct-complete suspend driver flags: 0
[  403.302401] vc vcs4: PM: direct-complete suspend driver flags: 0
[  403.302405] vc vcsa3: PM: direct-complete suspend driver flags: 0
[  403.302408] vc vcsu3: PM: direct-complete suspend driver flags: 0
[  403.302412] vc vcs3: PM: direct-complete suspend driver flags: 0
[  403.302416] vc vcsa2: PM: direct-complete suspend driver flags: 0
[  403.302420] vc vcsu2: PM: direct-complete suspend driver flags: 0
[  403.302423] vc vcs2: PM: direct-complete suspend driver flags: 0
[  403.302427] net lo: PM: direct-complete suspend driver flags: 0
[  403.302431] net lo: PM: direct-complete suspend driver flags: 0
[  403.302435] net wlp1s0: PM: direct-complete suspend driver flags: 0
[  403.302440] rfkill rfkill1: PM: class suspend driver flags: 0
[  403.303940] leds phy0-led: PM: class suspend driver flags: 0
[  403.303946] ieee80211 phy0: PM: class suspend driver flags: 0
[  403.303969]  card2: PM: direct-complete suspend driver flags: 0
[  403.303973]  card2: PM: direct-complete suspend driver flags: 0
[  403.303977] sound controlC2: PM: direct-complete suspend driver flags: 0
[  403.303981] sound pcmC2D0c: PM: type suspend driver flags: 0
[  403.303988]  acp3x-dmic-capture: PM: direct-complete suspend driver flags: 0
[  403.303992] acp_pdm_mach acp_pdm_mach.0: PM: bus suspend driver flags: 0
[  403.304187] wlp1s0: deauthenticating from d6:92:5e:eb:ee:15 by local choice (Reason: 3=DEAUTH_LEAVING)
[  403.304420]  card1: PM: direct-complete suspend driver flags: 0
[  403.304424]  card1: PM: direct-complete suspend driver flags: 0
[  403.304427] sound controlC1: PM: direct-complete suspend driver flags: 0
[  403.304431] input event10: PM: direct-complete suspend driver flags: 0
[  403.304434] input input14: PM: type suspend driver flags: 0
[  403.304445] input event9: PM: direct-complete suspend driver flags: 0
[  403.304450] input input13: PM: type suspend driver flags: 0
[  403.304454] sound hwC1D0: PM: direct-complete suspend driver flags: 0
[  403.304458] sound pcmC1D0c: PM: type suspend driver flags: 0
[  403.304463] sound pcmC1D0p: PM: type suspend driver flags: 0
[  403.304473]  card0: PM: direct-complete suspend driver flags: 0
[  403.304476]  card0: PM: direct-complete suspend driver flags: 0
[  403.304480]  mic: PM: direct-complete suspend driver flags: 0
[  403.304483]  speaker: PM: direct-complete suspend driver flags: 0
[  403.304487] sound ctl-led: PM: direct-complete suspend driver flags: 0
[  403.304490] faux_driver snd-soc-dummy: PM: direct-complete suspend driver flags: 0
[  403.304494] leds hda::mute: PM: class suspend driver flags: 0
[  403.305855] media media0: PM: direct-complete suspend driver flags: 0
[  403.305864] video4linux video1: PM: direct-complete suspend driver flags: 0
[  403.305864] snd_hda_codec_realtek hdaudioC1D0: PM: driver suspend driver flags: 0
[  403.305868] video4linux video0: PM: direct-complete suspend driver flags: 0
[  403.305907] snd_hda_intel 0000:03:00.6: PM: bus suspend driver flags: 0
[  403.306064] sound controlC0: PM: direct-complete suspend driver flags: 0
[  403.306068] input event8: PM: direct-complete suspend driver flags: 0
[  403.306074] input input12: PM: type suspend driver flags: 0
[  403.306081] sound hwC0D0: PM: direct-complete suspend driver flags: 0
[  403.306084] sound pcmC0D3p: PM: type suspend driver flags: 0
[  403.306093] uvcvideo 1-3:1.0: PM: direct-complete suspend driver flags: 0
[  403.306095] powercap intel-rapl:0:0: PM: direct-complete suspend driver flags: 0
[  403.306101] powercap intel-rapl:0: PM: direct-complete suspend driver flags: 0
[  403.306104] snd_hda_intel 0000:03:00.1: PM: bus suspend driver flags: 0
[  403.306108] powercap intel-rapl: PM: direct-complete suspend driver flags: 0
[  403.306113] hwmon hwmon8: PM: direct-complete suspend driver flags: 0
[  403.306122] thermal thermal_zone2: PM: direct-complete suspend driver flags: 0
[  403.306130] intel_rapl_msr intel_rapl_msr.0: PM: bus suspend driver flags: 0
[  403.306134] usb 1-3: PM: type suspend driver flags: 0
[  403.306136] misc kvm: PM: direct-complete suspend driver flags: 0
[  403.306140] usb_power_delivery pd0: PM: direct-complete suspend driver flags: 0
[  403.306144] typec port0: PM: direct-complete suspend driver flags: 0
[  403.306147] hwmon hwmon7: PM: direct-complete suspend driver flags: 0
[  403.306153] rfkill rfkill0: PM: class suspend driver flags: 0
[  403.306161] platform-profile platform-profile-0: PM: direct-complete suspend driver flags: 0
[  403.306165] hwmon hwmon6: PM: direct-complete suspend driver flags: 0
[  403.306168] usb usb1: PM: type suspend driver flags: 0
[  403.306172] hp-wmi hp-wmi: PM: bus suspend driver flags: 0
[  403.306178] input event7: PM: direct-complete suspend driver flags: 0
[  403.306180] usb 3-3: PM: type suspend driver flags: 0
[  403.306185] input input11: PM: type suspend driver flags: 0
[  403.306189] dmic-codec dmic-codec.0: PM: bus suspend driver flags: 0
[  403.306193] acp_rn_pdm_dma acp_rn_pdm_dma.0: PM: bus suspend driver flags: 0
[  403.306198] nvmem 3-0051: PM: direct-complete suspend driver flags: 0
[  403.306204] nvmem 3-0050: PM: direct-complete suspend driver flags: 0
[  403.306208] sound timer: PM: direct-complete suspend driver flags: 0
[  403.306212] scsi_generic sg0: PM: direct-complete suspend driver flags: 0
[  403.306215] platform regulatory.0: PM: bus suspend driver flags: 0
[  403.306219] event_source power_core: PM: direct-complete suspend driver flags: 0
[  403.306222] event_source power: PM: direct-complete suspend driver flags: 0
[  403.306225] watchdog watchdog0: PM: direct-complete suspend driver flags: 0
[  403.306226] snd_rn_pci_acp3x 0000:03:00.5: PM: bus suspend driver flags: 0
[  403.306228] misc watchdog: PM: direct-complete suspend driver flags: 0
[  403.306232] ee1004 3-0051: PM: direct-complete suspend driver flags: 0
[  403.306233] sp5100-tco sp5100-tco: PM: bus suspend driver flags: 0
[  403.306236] input event6: PM: direct-complete suspend driver flags: 0
[  403.306240] input input10: PM: type suspend driver flags: 0
[  403.306241] ee1004 3-0050: PM: direct-complete suspend driver flags: 0
[  403.306244] hwmon hwmon5: PM: direct-complete suspend driver flags: 0
[  403.306279] i2c i2c-3: PM: direct-complete suspend driver flags: 0
[  403.306299] piix4_smbus 0000:00:14.0: PM: bus suspend driver flags: 0
[  403.306453] hwmon hwmon4: PM: direct-complete suspend driver flags: 0
[  403.306455] k10temp 0000:00:18.3: PM: bus suspend driver flags: 0
[  403.306459] hwmon hwmon3: PM: direct-complete suspend driver flags: 0
[  403.306463] power_supply BAT0: PM: direct-complete suspend driver flags: 0
[  403.306466] misc rfkill: PM: direct-complete suspend driver flags: 0
[  403.306469] input event5: PM: direct-complete suspend driver flags: 0
[  403.306472] input event4: PM: direct-complete suspend driver flags: 0
[  403.306476] input event3: PM: direct-complete suspend driver flags: 0
[  403.306478] input event2: PM: direct-complete suspend driver flags: 0
[  403.306482] input event1: PM: direct-complete suspend driver flags: 0
[  403.306486] input event0: PM: direct-complete suspend driver flags: 0
[  403.306492] msr msr15: PM: direct-complete suspend driver flags: 0
[  403.306496] msr msr14: PM: direct-complete suspend driver flags: 0
[  403.306499] msr msr13: PM: direct-complete suspend driver flags: 0
[  403.306502] msr msr12: PM: direct-complete suspend driver flags: 0
[  403.306505] msr msr11: PM: direct-complete suspend driver flags: 0
[  403.306508] msr msr10: PM: direct-complete suspend driver flags: 0
[  403.306510] msr msr9: PM: direct-complete suspend driver flags: 0
[  403.306513] msr msr8: PM: direct-complete suspend driver flags: 0
[  403.306516] msr msr7: PM: direct-complete suspend driver flags: 0
[  403.306519] msr msr6: PM: direct-complete suspend driver flags: 0
[  403.306522] msr msr5: PM: direct-complete suspend driver flags: 0
[  403.306525] msr msr4: PM: direct-complete suspend driver flags: 0
[  403.306527] msr msr3: PM: direct-complete suspend driver flags: 0
[  403.306530] msr msr2: PM: direct-complete suspend driver flags: 0
[  403.306533] msr msr1: PM: direct-complete suspend driver flags: 0
[  403.306536] msr msr0: PM: direct-complete suspend driver flags: 0
[  403.306538] misc device-mapper: PM: direct-complete suspend driver flags: 0
[  403.306541] misc nvme-fabrics: PM: direct-complete suspend driver flags: 0
[  403.306545] nvme-fabrics ctl: PM: direct-complete suspend driver flags: 0
[  403.306548] misc autofs: PM: direct-complete suspend driver flags: 0
[  403.306551] bdi btrfs-1: PM: direct-complete suspend driver flags: 0
[  403.306554] block sda2: PM: direct-complete suspend driver flags: 0
[  403.306557] block sda1: PM: direct-complete suspend driver flags: 0
[  403.306560] bdi 8:0: PM: direct-complete suspend driver flags: 0
[  403.306564] block sda: PM: direct-complete suspend driver flags: 0
[  403.306567] scsi_disk 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  403.306570] bsg 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  403.306576] misc btrfs-control: PM: direct-complete suspend driver flags: 0
[  403.306580] workqueue scsi_tmf_0: PM: direct-complete suspend driver flags: 0
[  403.306584] vtconsole vtcon1: PM: direct-complete suspend driver flags: 0
[  403.306587] graphics fb0: PM: direct-complete suspend driver flags: 0
[  403.306591] drm_dp_aux_dev drm_dp_aux1: PM: direct-complete suspend driver flags: 0
[  403.306590] sd 0:0:0:0: PM: bus suspend driver flags: 0
[  403.306595] drm card0-DP-1: PM: direct-complete suspend driver flags: 0
[  403.306598] drm card0-HDMI-A-1: PM: direct-complete suspend driver flags: 0
[  403.306601] drm_dp_aux_dev drm_dp_aux0: PM: direct-complete suspend driver flags: 0
[  403.306604] backlight amdgpu_bl0: PM: class suspend driver flags: 0
[  403.307235] drm renderD128: PM: direct-complete suspend driver flags: 0
[  403.307238] hwmon hwmon2: PM: direct-complete suspend driver flags: 0
[  403.307243] kfd kfd: PM: direct-complete suspend driver flags: 0
[  403.307250] hidraw hidraw0: PM: direct-complete suspend driver flags: 0
[  403.307255] input mouse1: PM: direct-complete suspend driver flags: 0
[  403.307259] input input9: PM: type suspend driver flags: 0
[  403.307263] input mouse0: PM: direct-complete suspend driver flags: 0
[  403.307266] input input7: PM: type suspend driver flags: 0
[  403.307274] nvme-generic ng0n1: PM: direct-complete suspend driver flags: 0
[  403.307277] block nvme0n1p4: PM: direct-complete suspend driver flags: 0
[  403.307288] i2c_hid_acpi i2c-ELAN074E:00: PM: power domain suspend, may wakeup driver flags: 0
[  403.309132] block nvme0n1p3: PM: direct-complete suspend driver flags: 0
[  403.309138] block nvme0n1p2: PM: direct-complete suspend driver flags: 0
[  403.309142] block nvme0n1p1: PM: direct-complete suspend driver flags: 0
[  403.309146] bdi 259:0: PM: direct-complete suspend driver flags: 0
[  403.309152] block nvme0n1: PM: direct-complete suspend driver flags: 0
[  403.309158] hwmon hwmon1: PM: direct-complete suspend driver flags: 0
[  403.309163] nvme-subsystem nvme-subsys0: PM: direct-complete suspend driver flags: 0
[  403.309168] nvme nvme0: PM: direct-complete suspend driver flags: 0
[  403.309177] workqueue nvme-auth-wq: PM: direct-complete suspend driver flags: 0
[  403.309181] workqueue nvme-delete-wq: PM: direct-complete suspend driver flags: 0
[  403.309182] nvme 0000:02:00.0: PM: bus suspend driver flags: 0
[  403.309185] workqueue nvme-reset-wq: PM: direct-complete suspend driver flags: 0
[  403.309190] workqueue nvme-wq: PM: direct-complete suspend driver flags: 0
[  403.309195] input input3: PM: type suspend driver flags: 0
[  403.309202] thermal cooling_device16: PM: direct-complete suspend driver flags: 0
[  403.309207] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-4: PM: direct-complete suspend driver flags: 0
[  403.309212] wmi ABBC0F6A-8EA1-11D1-00A0-C90629100000: PM: direct-complete suspend driver flags: 0
[  403.309217] input input2: PM: type suspend driver flags: 0
[  403.309223] wmi_bus wmi_bus-PNP0C14:04: PM: direct-complete suspend driver flags: 0
[  403.309228] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-3: PM: direct-complete suspend driver flags: 0
[  403.309233] wmi 40D1BF71-A82D-4E59-A168-3985E03B2E87: PM: direct-complete suspend driver flags: 0
[  403.309237] wmi 431F16ED-0C2B-444C-B267-27DEB140CF9C: PM: direct-complete suspend driver flags: 0
[  403.309241] wmi 67C3371D-95A3-4C37-BB61-DD47B491DAAB: PM: direct-complete suspend driver flags: 0
[  403.309245] wmi D9F41781-F633-4400-9355-601770BEC510: PM: direct-complete suspend driver flags: 0
[  403.309250] wmi_bus wmi_bus-PNP0C14:03: PM: direct-complete suspend driver flags: 0
[  403.309255] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-2: PM: direct-complete suspend driver flags: 0
[  403.309259] wmi 1F13AB7F-6220-4210-8F8E-8BB5E71EE969: PM: direct-complete suspend driver flags: 0
[  403.309264] input input1: PM: type suspend driver flags: 0
[  403.309270] wmi_bus wmi_bus-PNP0C14:02: PM: direct-complete suspend driver flags: 0
[  403.309275] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-1: PM: direct-complete suspend driver flags: 0
[  403.309279] wmi A6FEA33E-DABF-46F5-BFC8-460D961BEC9F: PM: direct-complete suspend driver flags: 0
[  403.309284] wmi 2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B: PM: direct-complete suspend driver flags: 0
[  403.309288] wmi_bus wmi_bus-PNP0C14:01: PM: direct-complete suspend driver flags: 0
[  403.309292] wmi 8232DE3D-663D-4327-A8F4-E293ADB9BF05: PM: direct-complete suspend driver flags: 0
[  403.309296] wmi 322F2028-0F84-4901-988E-015176049E2D: PM: direct-complete suspend driver flags: 0
[  403.309299] wmi 14EA9746-CE1F-4098-A0E0-7045CB4DA745: PM: direct-complete suspend driver flags: 0
[  403.309303] wmi 988D08E3-68F4-4C35-AF3E-6A1B8106F83C: PM: direct-complete suspend driver flags: 0
[  403.309306] wmi 2D114B49-2DFB-4130-B8FE-4A3C09E75133: PM: direct-complete suspend driver flags: 0
[  403.309310] wmi 1F4C91EB-DC5C-460B-951D-C7CB9B4B8D5E: PM: direct-complete suspend driver flags: 0
[  403.309313] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910: PM: direct-complete suspend driver flags: 0
[  403.309317] wmi 2B814318-4BE8-4707-9D84-A190A859B5D0: PM: direct-complete suspend driver flags: 0
[  403.309320] wmi 95F24279-4D7B-4334-9387-ACCDC67EF61C: PM: direct-complete suspend driver flags: 0
[  403.309324] wmi 5FB7F034-2C63-45E9-BE91-3D44E2C707E4: PM: direct-complete suspend driver flags: 0
[  403.309330] wmi_bus wmi_bus-PNP0C14:00: PM: direct-complete suspend driver flags: 0
[  403.309334] memory_tiering memory_tier4: PM: direct-complete suspend driver flags: 0
[  403.309338] misc cpu_dma_latency: PM: direct-complete suspend driver flags: 0
[  403.309341] platform microcode: PM: bus suspend driver flags: 0
[  403.309346] machinecheck machinecheck15: PM: direct-complete suspend driver flags: 0
[  403.309349] machinecheck machinecheck14: PM: direct-complete suspend driver flags: 0
[  403.309352] machinecheck machinecheck13: PM: direct-complete suspend driver flags: 0
[  403.309356] machinecheck machinecheck12: PM: direct-complete suspend driver flags: 0
[  403.309359] machinecheck machinecheck11: PM: direct-complete suspend driver flags: 0
[  403.309363] machinecheck machinecheck10: PM: direct-complete suspend driver flags: 0
[  403.309366] machinecheck machinecheck9: PM: direct-complete suspend driver flags: 0
[  403.309369] machinecheck machinecheck8: PM: direct-complete suspend driver flags: 0
[  403.309372] machinecheck machinecheck7: PM: direct-complete suspend driver flags: 0
[  403.309376] machinecheck machinecheck6: PM: direct-complete suspend driver flags: 0
[  403.309379] machinecheck machinecheck5: PM: direct-complete suspend driver flags: 0
[  403.309383] machinecheck machinecheck4: PM: direct-complete suspend driver flags: 0
[  403.309386] machinecheck machinecheck3: PM: direct-complete suspend driver flags: 0
[  403.309389] machinecheck machinecheck2: PM: direct-complete suspend driver flags: 0
[  403.309393] machinecheck machinecheck1: PM: direct-complete suspend driver flags: 0
[  403.309396] machinecheck machinecheck0: PM: direct-complete suspend driver flags: 0
[  403.309399]  machinecheck: PM: direct-complete suspend driver flags: 0
[  403.309402] leds input0::scrolllock: PM: class suspend driver flags: 0
[  403.309407] leds input0::capslock: PM: class suspend driver flags: 0
[  403.309411] leds input0::numlock: PM: class suspend driver flags: 0
[  403.309416] input input0: PM: type suspend driver flags: 0
[  403.309421] nvmem cmos_nvram0: PM: direct-complete suspend driver flags: 0
[  403.309425] alarmtimer alarmtimer.0.auto: PM: bus suspend, may wakeup driver flags: 0
[  403.310733] rtc rtc0: PM: class suspend driver flags: 0
[  403.310736] misc psaux: PM: direct-complete suspend driver flags: 0
[  403.310740] atkbd serio0: PM: bus suspend, may wakeup driver flags: 0
[  403.311262] i2c_designware AMDI0010:03: PM: power domain suspend driver flags: 6
[  403.315308] input mice: PM: direct-complete suspend driver flags: 0
[  403.315312] i8042 i8042: PM: bus suspend driver flags: 0
[  403.315325] misc udmabuf: PM: direct-complete suspend driver flags: 0
[  403.315328] dma_heap system: PM: direct-complete suspend driver flags: 0
[  403.315331] tpmrm tpmrm0: PM: direct-complete suspend driver flags: 0
[  403.315333] tpm tpm0: PM: direct-complete suspend driver flags: 0
[  403.315336] misc hpet: PM: direct-complete suspend driver flags: 0
[  403.315338] tty ttyS3: PM: direct-complete suspend driver flags: 0
[  403.315342] port serial8250:0.3: PM: driver suspend driver flags: 0
[  403.315345] tty ttyS2: PM: direct-complete suspend driver flags: 0
[  403.315348] port serial8250:0.2: PM: driver suspend driver flags: 0
[  403.315350] tty ttyS1: PM: direct-complete suspend driver flags: 0
[  403.315353] port serial8250:0.1: PM: driver suspend driver flags: 0
[  403.315356] tty ttyS0: PM: direct-complete suspend driver flags: 0
[  403.315358] port serial8250:0.0: PM: driver suspend driver flags: 0
[  403.315364] serial8250 serial8250: PM: bus suspend driver flags: 0
[  403.315368] tty ptmx: PM: direct-complete suspend driver flags: 0
[  403.315371] thermal thermal_zone1: PM: direct-complete suspend driver flags: 0
[  403.315373] hwmon hwmon0: PM: direct-complete suspend driver flags: 0
[  403.315376] thermal thermal_zone0: PM: direct-complete suspend driver flags: 0
[  403.315378] thermal cooling_device15: PM: direct-complete suspend driver flags: 0
[  403.315380] thermal cooling_device14: PM: direct-complete suspend driver flags: 0
[  403.315382] thermal cooling_device13: PM: direct-complete suspend driver flags: 0
[  403.315385] thermal cooling_device12: PM: direct-complete suspend driver flags: 0
[  403.315387] thermal cooling_device11: PM: direct-complete suspend driver flags: 0
[  403.315389] thermal cooling_device10: PM: direct-complete suspend driver flags: 0
[  403.315392] thermal cooling_device9: PM: direct-complete suspend driver flags: 0
[  403.315394] thermal cooling_device8: PM: direct-complete suspend driver flags: 0
[  403.315396] thermal cooling_device7: PM: direct-complete suspend driver flags: 0
[  403.315398] thermal cooling_device6: PM: direct-complete suspend driver flags: 0
[  403.315401] thermal cooling_device5: PM: direct-complete suspend driver flags: 0
[  403.315403] thermal cooling_device4: PM: direct-complete suspend driver flags: 0
[  403.315405] thermal cooling_device3: PM: direct-complete suspend driver flags: 0
[  403.315407] thermal cooling_device2: PM: direct-complete suspend driver flags: 0
[  403.315409] thermal cooling_device1: PM: direct-complete suspend driver flags: 0
[  403.315412] thermal cooling_device0: PM: direct-complete suspend driver flags: 0
[  403.315415] gpio gpiochip512: PM: direct-complete suspend driver flags: 0
[  403.315417] gpio gpiochip0: PM: direct-complete suspend driver flags: 0
[  403.315420] misc fuse: PM: direct-complete suspend driver flags: 0
[  403.315422] misc userfaultfd: PM: direct-complete suspend driver flags: 0
[  403.315425] event_source software: PM: direct-complete suspend driver flags: 0
[  403.315427] event_source tracepoint: PM: direct-complete suspend driver flags: 0
[  403.315430] event_source kprobe: PM: direct-complete suspend driver flags: 0
[  403.315432] event_source uprobe: PM: direct-complete suspend driver flags: 0
[  403.315434] event_source breakpoint: PM: direct-complete suspend driver flags: 0
[  403.315436] event_source cpu: PM: direct-complete suspend driver flags: 0
[  403.315439] event_source ibs_fetch: PM: direct-complete suspend driver flags: 0
[  403.315441] event_source ibs_op: PM: direct-complete suspend driver flags: 0
[  403.315443] event_source amd_df: PM: direct-complete suspend driver flags: 0
[  403.315445] event_source amd_l3: PM: direct-complete suspend driver flags: 0
[  403.315448] event_source amd_iommu_0: PM: direct-complete suspend driver flags: 0
[  403.315452] event_source msr: PM: direct-complete suspend driver flags: 0
[  403.315456] clockevents broadcast: PM: direct-complete suspend driver flags: 0
[  403.315460] clockevents clockevent15: PM: direct-complete suspend driver flags: 0
[  403.315464] clockevents clockevent14: PM: direct-complete suspend driver flags: 0
[  403.315467] clockevents clockevent13: PM: direct-complete suspend driver flags: 0
[  403.315470] clockevents clockevent12: PM: direct-complete suspend driver flags: 0
[  403.315474] clockevents clockevent11: PM: direct-complete suspend driver flags: 0
[  403.315477] clockevents clockevent10: PM: direct-complete suspend driver flags: 0
[  403.315480] clockevents clockevent9: PM: direct-complete suspend driver flags: 0
[  403.315484] clockevents clockevent8: PM: direct-complete suspend driver flags: 0
[  403.315487] clockevents clockevent7: PM: direct-complete suspend driver flags: 0
[  403.315490] clockevents clockevent6: PM: direct-complete suspend driver flags: 0
[  403.315494] clockevents clockevent5: PM: direct-complete suspend driver flags: 0
[  403.315497] clockevents clockevent4: PM: direct-complete suspend driver flags: 0
[  403.315500] clockevents clockevent3: PM: direct-complete suspend driver flags: 0
[  403.315503] clockevents clockevent2: PM: direct-complete suspend driver flags: 0
[  403.315506] clockevents clockevent1: PM: direct-complete suspend driver flags: 0
[  403.315510] clockevents clockevent0: PM: direct-complete suspend driver flags: 0
[  403.315513]  clockevents: PM: direct-complete suspend driver flags: 0
[  403.315516] clocksource clocksource0: PM: direct-complete suspend driver flags: 0
[  403.315519]  clocksource: PM: direct-complete suspend driver flags: 0
[  403.315522] misc snapshot: PM: direct-complete suspend driver flags: 0
[  403.315526] pcspkr pcspkr: PM: bus suspend driver flags: 0
[  403.315596] iommu ivhd0: PM: direct-complete suspend driver flags: 0
[  403.315609] misc hw_random: PM: direct-complete suspend driver flags: 0
[  403.315616] tty tty63: PM: direct-complete suspend driver flags: 0
[  403.315617] pci 0000:00:00.2: PM: bus suspend driver flags: 0
[  403.315622] tty tty62: PM: direct-complete suspend driver flags: 0
[  403.315628] tty tty61: PM: direct-complete suspend driver flags: 0
[  403.315634] tty tty60: PM: direct-complete suspend driver flags: 0
[  403.315641] tty tty59: PM: direct-complete suspend driver flags: 0
[  403.315647] tty tty58: PM: direct-complete suspend driver flags: 0
[  403.315653] tty tty57: PM: direct-complete suspend driver flags: 0
[  403.315657] tty tty56: PM: direct-complete suspend driver flags: 0
[  403.315660] tty tty55: PM: direct-complete suspend driver flags: 0
[  403.315663] tty tty54: PM: direct-complete suspend driver flags: 0
[  403.315667] tty tty53: PM: direct-complete suspend driver flags: 0
[  403.315670] tty tty52: PM: direct-complete suspend driver flags: 0
[  403.315673] tty tty51: PM: direct-complete suspend driver flags: 0
[  403.315677] tty tty50: PM: direct-complete suspend driver flags: 0
[  403.315680] tty tty49: PM: direct-complete suspend driver flags: 0
[  403.315683] tty tty48: PM: direct-complete suspend driver flags: 0
[  403.315686] tty tty47: PM: direct-complete suspend driver flags: 0
[  403.315689] tty tty46: PM: direct-complete suspend driver flags: 0
[  403.315693] tty tty45: PM: direct-complete suspend driver flags: 0
[  403.315696] tty tty44: PM: direct-complete suspend driver flags: 0
[  403.315699] tty tty43: PM: direct-complete suspend driver flags: 0
[  403.315702] tty tty42: PM: direct-complete suspend driver flags: 0
[  403.315706] tty tty41: PM: direct-complete suspend driver flags: 0
[  403.315709] tty tty40: PM: direct-complete suspend driver flags: 0
[  403.315712] tty tty39: PM: direct-complete suspend driver flags: 0
[  403.315715] tty tty38: PM: direct-complete suspend driver flags: 0
[  403.315719] tty tty37: PM: direct-complete suspend driver flags: 0
[  403.315722] tty tty36: PM: direct-complete suspend driver flags: 0
[  403.315725] tty tty35: PM: direct-complete suspend driver flags: 0
[  403.315728] tty tty34: PM: direct-complete suspend driver flags: 0
[  403.315731] tty tty33: PM: direct-complete suspend driver flags: 0
[  403.315734] tty tty32: PM: direct-complete suspend driver flags: 0
[  403.315738] tty tty31: PM: direct-complete suspend driver flags: 0
[  403.315741] tty tty30: PM: direct-complete suspend driver flags: 0
[  403.315744] tty tty29: PM: direct-complete suspend driver flags: 0
[  403.315747] tty tty28: PM: direct-complete suspend driver flags: 0
[  403.315751] tty tty27: PM: direct-complete suspend driver flags: 0
[  403.315754] tty tty26: PM: direct-complete suspend driver flags: 0
[  403.315757] tty tty25: PM: direct-complete suspend driver flags: 0
[  403.315761] tty tty24: PM: direct-complete suspend driver flags: 0
[  403.315764] tty tty23: PM: direct-complete suspend driver flags: 0
[  403.315767] tty tty22: PM: direct-complete suspend driver flags: 0
[  403.315770] tty tty21: PM: direct-complete suspend driver flags: 0
[  403.315773] tty tty20: PM: direct-complete suspend driver flags: 0
[  403.315776] tty tty19: PM: direct-complete suspend driver flags: 0
[  403.315780] tty tty18: PM: direct-complete suspend driver flags: 0
[  403.315783] tty tty17: PM: direct-complete suspend driver flags: 0
[  403.315786] tty tty16: PM: direct-complete suspend driver flags: 0
[  403.315789] tty tty15: PM: direct-complete suspend driver flags: 0
[  403.315792] tty tty14: PM: direct-complete suspend driver flags: 0
[  403.315795] tty tty13: PM: direct-complete suspend driver flags: 0
[  403.315799] tty tty12: PM: direct-complete suspend driver flags: 0
[  403.315802] tty tty11: PM: direct-complete suspend driver flags: 0
[  403.315805] tty tty10: PM: direct-complete suspend driver flags: 0
[  403.315808] tty tty9: PM: direct-complete suspend driver flags: 0
[  403.315812] tty tty8: PM: direct-complete suspend driver flags: 0
[  403.315815] tty tty7: PM: direct-complete suspend driver flags: 0
[  403.315818] tty tty6: PM: direct-complete suspend driver flags: 0
[  403.315822] tty tty5: PM: direct-complete suspend driver flags: 0
[  403.315825] tty tty4: PM: direct-complete suspend driver flags: 0
[  403.315828] tty tty3: PM: direct-complete suspend driver flags: 0
[  403.315831] tty tty2: PM: direct-complete suspend driver flags: 0
[  403.315834] tty tty1: PM: direct-complete suspend driver flags: 0
[  403.315838] vc vcsa1: PM: direct-complete suspend driver flags: 0
[  403.315841] vc vcsu1: PM: direct-complete suspend driver flags: 0
[  403.315844] vc vcs1: PM: direct-complete suspend driver flags: 0
[  403.315848] vc vcsa: PM: direct-complete suspend driver flags: 0
[  403.315851] vc vcsu: PM: direct-complete suspend driver flags: 0
[  403.315854] vc vcs: PM: direct-complete suspend driver flags: 0
[  403.315857] tty tty0: PM: direct-complete suspend driver flags: 0
[  403.315861] tty console: PM: direct-complete suspend driver flags: 0
[  403.315864] tty tty: PM: direct-complete suspend driver flags: 0
[  403.315867] mem kmsg: PM: direct-complete suspend driver flags: 0
[  403.315871] mem urandom: PM: direct-complete suspend driver flags: 0
[  403.315874] mem random: PM: direct-complete suspend driver flags: 0
[  403.315877] mem full: PM: direct-complete suspend driver flags: 0
[  403.315882] mem zero: PM: direct-complete suspend driver flags: 0
[  403.315887] mem port: PM: direct-complete suspend driver flags: 0
[  403.315892] mem null: PM: direct-complete suspend driver flags: 0
[  403.315895] mem mem: PM: direct-complete suspend driver flags: 0
[  403.315901] system 00:03: PM: bus suspend driver flags: 0
[  403.315906] i8042 kbd 00:02: PM: bus suspend driver flags: 0
[  403.315912] rtc_cmos 00:01: PM: bus suspend, may wakeup driver flags: 0
[  403.315968] system 00:00: PM: bus suspend driver flags: 0
[  403.315975] misc vga_arbiter: PM: direct-complete suspend driver flags: 0
[  403.315979] net lo: PM: direct-complete suspend driver flags: 0
[  403.315983] platform efivars.0: PM: bus suspend driver flags: 0
[  403.315987] platform rtc-efi.0: PM: bus suspend driver flags: 0
[  403.315991] edac mc: PM: direct-complete suspend driver flags: 0
[  403.315994]  edac: PM: direct-complete suspend driver flags: 0
[  403.315999] acpi ELAN074E:00: PM: direct-complete suspend driver flags: 0
[  403.316003] acpi-wmi PNP0C14:04: PM: power domain suspend driver flags: 0
[  403.316008] platform PNP0103:00: PM: bus suspend driver flags: 0
[  403.316012] acpi-fan PNP0C0B:00: PM: bus suspend driver flags: 0
[  403.316017] amd_pmc AMDI0005:00: PM: power domain suspend driver flags: 0
[  403.316023] ucsi_acpi USBC000:00: PM: power domain suspend driver flags: 0
[  403.316027] platform ACPI000E:00: PM: bus suspend driver flags: 0
[  403.316032] acpi-wmi PNP0C14:03: PM: power domain suspend driver flags: 0
[  403.316036] platform PNP0C0D:00: PM: bus suspend driver flags: 0
[  403.316041] acpi-wmi PNP0C14:02: PM: power domain suspend driver flags: 0
[  403.316046] acpi-wmi PNP0C14:01: PM: power domain suspend driver flags: 0
[  403.316051] acpi-wmi PNP0C14:00: PM: power domain suspend driver flags: 0
[  403.316056] platform MSFT0101:00: PM: bus suspend driver flags: 0
[  403.316060] amd_gpio AMDI0030:00: PM: power domain suspend driver flags: 0
[  403.316065] platform acpi-cpufreq: PM: bus suspend driver flags: 0
[  403.316069] platform PNP0C0C:00: PM: bus suspend driver flags: 0
[  403.316073] platform HPIC0003:00: PM: bus suspend driver flags: 0
[  403.316077] platform PNP0C0A:00: PM: bus suspend driver flags: 0
[  403.316081] ac ACPI0003:00: PM: power domain suspend driver flags: 0
[  403.316086] platform PNP0C09:00: PM: bus suspend driver flags: 0
[  403.316095] platform PNP0800:00: PM: bus suspend driver flags: 0
[  403.316104] pci 0000:00:14.3: PM: bus suspend driver flags: 0
[  403.316130] pci_bus 0000:03: PM: direct-complete suspend driver flags: 0
[  403.316139] pci_bus 0000:02: PM: direct-complete suspend driver flags: 0
[  403.316144] pci_bus 0000:01: PM: direct-complete suspend driver flags: 0
[  403.316152] pci_bus 0000:00: PM: direct-complete suspend driver flags: 0
[  403.316158] acpi PNP0C14:04: PM: direct-complete suspend driver flags: 0
[  403.316162] acpi PNP0103:00: PM: direct-complete suspend driver flags: 0
[  403.316166] thermal LNXTHERM:01: PM: driver suspend driver flags: 0
[  403.316255] thermal LNXTHERM:00: PM: driver suspend driver flags: 0
[  403.316264] acpi PNP0C0B:00: PM: direct-complete suspend driver flags: 0
[  403.316268] acpi LNXPOWER:09: PM: direct-complete suspend driver flags: 0
[  403.316276] acpi AMDI0005:00: PM: direct-complete suspend driver flags: 0
[  403.316279] acpi device:3f: PM: direct-complete suspend driver flags: 0
[  403.316283] acpi USBC000:00: PM: direct-complete suspend driver flags: 0
[  403.316287] acpi ACPI000C:00: PM: direct-complete suspend driver flags: 0
[  403.316291] acpi ACPI000E:00: PM: direct-complete suspend driver flags: 0
[  403.316294] acpi PNP0C02:0d: PM: direct-complete suspend driver flags: 0
[  403.316298] acpi PNP0C02:0c: PM: direct-complete suspend driver flags: 0
[  403.316301] acpi PNP0C02:0b: PM: direct-complete suspend driver flags: 0
[  403.316304] acpi PNP0C02:0a: PM: direct-complete suspend driver flags: 0
[  403.316308] acpi PNP0C02:09: PM: direct-complete suspend driver flags: 0
[  403.316311] acpi PNP0C02:08: PM: direct-complete suspend driver flags: 0
[  403.316315] acpi PNP0C02:07: PM: direct-complete suspend driver flags: 0
[  403.316318] acpi PNP0C02:06: PM: direct-complete suspend driver flags: 0
[  403.316322] acpi PNP0C02:05: PM: direct-complete suspend driver flags: 0
[  403.316325] acpi PNP0C02:04: PM: direct-complete suspend driver flags: 0
[  403.316331] acpi PNP0C02:03: PM: direct-complete suspend driver flags: 0
[  403.316335] acpi LNXPOWER:08: PM: direct-complete suspend driver flags: 0
[  403.316338] acpi LNXPOWER:07: PM: direct-complete suspend driver flags: 0
[  403.316342] acpi HPQ6007:00: PM: direct-complete suspend driver flags: 0
[  403.316345] acpi HPQ6001:00: PM: direct-complete suspend driver flags: 0
[  403.316349] acpi PNP0C14:03: PM: direct-complete suspend driver flags: 0
[  403.316352] acpi PNP0C0E:00: PM: direct-complete suspend driver flags: 0
[  403.316357] button PNP0C0D:00: PM: driver suspend, may wakeup driver flags: 0
[  403.316363] acpi PNP0C14:02: PM: direct-complete suspend driver flags: 0
[  403.316367] acpi PNP0C14:01: PM: direct-complete suspend driver flags: 0
[  403.316370] acpi PNP0C14:00: PM: direct-complete suspend driver flags: 0
[  403.316374] tpm_crb MSFT0101:00: PM: driver suspend driver flags: 0
[  403.322976] amdgpu 0000:03:00.0: PM: bus suspend driver flags: 0
[  403.323647] xhci_hcd 0000:03:00.3: PM: bus suspend, may wakeup driver flags: 0
[  403.361943] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  403.363306] scsi target0:0:0: PM: bus suspend driver flags: 0
[  403.363339] scsi host0: PM: bus suspend driver flags: 0
[  403.363376] usb 4-1: PM: type suspend driver flags: 0
[  403.365332] acpi AMDI0040:00: PM: direct-complete suspend driver flags: 0
[  403.365338] acpi AMDI0010:05: PM: direct-complete suspend driver flags: 0
[  403.365343] acpi AMDI0010:04: PM: direct-complete suspend driver flags: 0
[  403.365348] acpi AMDI0010:03: PM: direct-complete suspend driver flags: 0
[  403.365353] acpi AMDI0010:02: PM: direct-complete suspend driver flags: 0
[  403.365356] acpi AMDI0010:01: PM: direct-complete suspend driver flags: 0
[  403.365360] acpi AMDI0010:00: PM: direct-complete suspend driver flags: 0
[  403.365364] acpi AMDI0020:03: PM: direct-complete suspend driver flags: 0
[  403.365368] acpi AMDI0020:02: PM: direct-complete suspend driver flags: 0
[  403.365372] acpi AMDI0020:01: PM: direct-complete suspend driver flags: 0
[  403.365375] acpi AMDI0020:00: PM: direct-complete suspend driver flags: 0
[  403.365380] acpi AMDI0030:00: PM: direct-complete suspend driver flags: 0
[  403.365384] acpi AMDI0060:00: PM: direct-complete suspend driver flags: 0
[  403.365387] acpi PNP0C0F:07: PM: direct-complete suspend driver flags: 0
[  403.365391] acpi PNP0C0F:06: PM: direct-complete suspend driver flags: 0
[  403.365395] acpi PNP0C0F:05: PM: direct-complete suspend driver flags: 0
[  403.365399] acpi PNP0C0F:04: PM: direct-complete suspend driver flags: 0
[  403.365403] acpi PNP0C0F:03: PM: direct-complete suspend driver flags: 0
[  403.365407] acpi PNP0C0F:02: PM: direct-complete suspend driver flags: 0
[  403.365410] acpi PNP0C0F:01: PM: direct-complete suspend driver flags: 0
[  403.365414] acpi PNP0C0F:00: PM: direct-complete suspend driver flags: 0
[  403.365418] acpi ACPI0007:0f: PM: direct-complete suspend driver flags: 0
[  403.365422] acpi ACPI0007:0e: PM: direct-complete suspend driver flags: 0
[  403.365426] acpi ACPI0007:0d: PM: direct-complete suspend driver flags: 0
[  403.365430] acpi ACPI0007:0c: PM: direct-complete suspend driver flags: 0
[  403.365433] acpi ACPI0007:0b: PM: direct-complete suspend driver flags: 0
[  403.365437] acpi ACPI0007:0a: PM: direct-complete suspend driver flags: 0
[  403.365441] acpi ACPI0007:09: PM: direct-complete suspend driver flags: 0
[  403.365445] acpi ACPI0007:08: PM: direct-complete suspend driver flags: 0
[  403.365448] acpi ACPI0007:07: PM: direct-complete suspend driver flags: 0
[  403.365452] acpi ACPI0007:06: PM: direct-complete suspend driver flags: 0
[  403.365456] acpi ACPI0007:05: PM: direct-complete suspend driver flags: 0
[  403.365460] acpi ACPI0007:04: PM: direct-complete suspend driver flags: 0
[  403.365464] acpi ACPI0007:03: PM: direct-complete suspend driver flags: 0
[  403.365468] acpi ACPI0007:02: PM: direct-complete suspend driver flags: 0
[  403.365471] acpi ACPI0007:01: PM: direct-complete suspend driver flags: 0
[  403.365475] acpi ACPI0007:00: PM: direct-complete suspend driver flags: 0
[  403.365484] acpi ACPI0010:00: PM: direct-complete suspend driver flags: 0
[  403.365489] button PNP0C0C:00: PM: driver suspend, may wakeup driver flags: 0
[  403.365495] acpi device:3e: PM: direct-complete suspend driver flags: 0
[  403.365500] acpi device:3d: PM: direct-complete suspend driver flags: 0
[  403.365504] acpi device:3c: PM: direct-complete suspend driver flags: 0
[  403.365508] acpi device:3b: PM: direct-complete suspend driver flags: 0
[  403.365513] acpi device:3a: PM: direct-complete suspend driver flags: 0
[  403.365517] acpi device:39: PM: direct-complete suspend driver flags: 0
[  403.365521] acpi device:38: PM: direct-complete suspend driver flags: 0
[  403.365525] acpi device:37: PM: direct-complete suspend driver flags: 0
[  403.365530] acpi device:36: PM: direct-complete suspend driver flags: 0
[  403.365534] acpi device:35: PM: direct-complete suspend driver flags: 0
[  403.365538] acpi device:34: PM: direct-complete suspend driver flags: 0
[  403.365542] acpi HPIC0003:00: PM: direct-complete suspend driver flags: 0
[  403.365546] acpi PNP0500:03: PM: direct-complete suspend driver flags: 0
[  403.365550] acpi PNP0500:02: PM: direct-complete suspend driver flags: 0
[  403.365554] acpi PNP0500:01: PM: direct-complete suspend driver flags: 0
[  403.365557] acpi PNP0500:00: PM: direct-complete suspend driver flags: 0
[  403.365561] acpi device:33: PM: direct-complete suspend driver flags: 0
[  403.365566] acpi device:32: PM: direct-complete suspend driver flags: 0
[  403.365570] acpi device:31: PM: direct-complete suspend driver flags: 0
[  403.365574] acpi device:30: PM: direct-complete suspend driver flags: 0
[  403.365578] acpi device:2f: PM: direct-complete suspend driver flags: 0
[  403.365582] acpi LNXPOWER:06: PM: direct-complete suspend driver flags: 0
[  403.365586] acpi device:2e: PM: direct-complete suspend driver flags: 0
[  403.365591] acpi device:2d: PM: direct-complete suspend driver flags: 0
[  403.365595] acpi device:2c: PM: direct-complete suspend driver flags: 0
[  403.365598] acpi PNP0C02:02: PM: direct-complete suspend driver flags: 0
[  403.365602] acpi SYNA3290:00: PM: direct-complete suspend driver flags: 0
[  403.365606] acpi HPQ8001:00: PM: direct-complete suspend driver flags: 0
[  403.365615] acpi ACPI0003:00: PM: direct-complete suspend driver flags: 0
[  403.365620] ec PNP0C09:00: PM: driver suspend driver flags: 0
[  403.365625] acpi PNP0800:00: PM: direct-complete suspend driver flags: 0
[  403.365629] acpi PNP0B00:00: PM: direct-complete suspend driver flags: 0
[  403.365632] acpi PNP0100:00: PM: direct-complete suspend driver flags: 0
[  403.365636] acpi PNP0200:00: PM: direct-complete suspend driver flags: 0
[  403.365640] acpi PNP0000:00: PM: direct-complete suspend driver flags: 0
[  403.365650] acpi device:2a: PM: direct-complete suspend driver flags: 0
[  403.365653] acpi device:29: PM: direct-complete suspend driver flags: 0
[  403.365658] acpi device:28: PM: direct-complete suspend driver flags: 0
[  403.365661] acpi device:27: PM: direct-complete suspend driver flags: 0
[  403.365666] acpi device:26: PM: direct-complete suspend driver flags: 0
[  403.365669] acpi device:25: PM: direct-complete suspend driver flags: 0
[  403.365673] acpi LNXPOWER:05: PM: direct-complete suspend driver flags: 0
[  403.365677] acpi device:24: PM: direct-complete suspend driver flags: 0
[  403.365681] acpi LNXPOWER:04: PM: direct-complete suspend driver flags: 0
[  403.365685] acpi device:23: PM: direct-complete suspend driver flags: 0
[  403.365689] acpi device:22: PM: direct-complete suspend driver flags: 0
[  403.365693] acpi device:21: PM: direct-complete suspend driver flags: 0
[  403.365697] acpi device:20: PM: direct-complete suspend driver flags: 0
[  403.365701] acpi device:1f: PM: direct-complete suspend driver flags: 0
[  403.365705] acpi device:1e: PM: direct-complete suspend driver flags: 0
[  403.365709] acpi device:1d: PM: direct-complete suspend driver flags: 0
[  403.365712] acpi device:1c: PM: direct-complete suspend driver flags: 0
[  403.365717] acpi device:1b: PM: direct-complete suspend driver flags: 0
[  403.365722] acpi device:1a: PM: direct-complete suspend driver flags: 0
[  403.365726] acpi LNXPOWER:03: PM: direct-complete suspend driver flags: 0
[  403.365729] acpi LNXPOWER:02: PM: direct-complete suspend driver flags: 0
[  403.365733] acpi device:19: PM: direct-complete suspend driver flags: 0
[  403.365737] acpi device:18: PM: direct-complete suspend driver flags: 0
[  403.365740] acpi device:17: PM: direct-complete suspend driver flags: 0
[  403.365744] acpi device:16: PM: direct-complete suspend driver flags: 0
[  403.365748] acpi device:15: PM: direct-complete suspend driver flags: 0
[  403.365752] acpi device:14: PM: direct-complete suspend driver flags: 0
[  403.365756] acpi device:13: PM: direct-complete suspend driver flags: 0
[  403.365759] acpi device:12: PM: direct-complete suspend driver flags: 0
[  403.365764] acpi device:11: PM: direct-complete suspend driver flags: 0
[  403.365768] acpi device:10: PM: direct-complete suspend driver flags: 0
[  403.365772] acpi LNXPOWER:01: PM: direct-complete suspend driver flags: 0
[  403.365776] acpi LNXPOWER:00: PM: direct-complete suspend driver flags: 0
[  403.365780] acpi device:0f: PM: direct-complete suspend driver flags: 0
[  403.365784] acpi device:0e: PM: direct-complete suspend driver flags: 0
[  403.365788] acpi PNP0C02:01: PM: direct-complete suspend driver flags: 0
[  403.365792] acpi device:0d: PM: direct-complete suspend driver flags: 0
[  403.365797] acpi device:0c: PM: direct-complete suspend driver flags: 0
[  403.365801] acpi device:0b: PM: direct-complete suspend driver flags: 0
[  403.365839] acpi device:09: PM: direct-complete suspend driver flags: 0
[  403.365844] acpi device:08: PM: direct-complete suspend driver flags: 0
[  403.365848] acpi device:07: PM: direct-complete suspend driver flags: 0
[  403.365852] acpi device:06: PM: direct-complete suspend driver flags: 0
[  403.365856] acpi device:05: PM: direct-complete suspend driver flags: 0
[  403.365860] acpi device:04: PM: direct-complete suspend driver flags: 0
[  403.365863] acpi device:03: PM: direct-complete suspend driver flags: 0
[  403.365867] acpi device:02: PM: direct-complete suspend driver flags: 0
[  403.365871] acpi device:01: PM: direct-complete suspend driver flags: 0
[  403.365875] acpi device:00: PM: direct-complete suspend driver flags: 0
[  403.365880] acpi PNP0C02:00: PM: direct-complete suspend driver flags: 0
[  403.365883] acpi PNP0C01:00: PM: direct-complete suspend driver flags: 0
[  403.365933] graphics fbcon: PM: direct-complete suspend driver flags: 0
[  403.365937] workqueue blkcg_punt_bio: PM: direct-complete suspend driver flags: 0
[  403.365941]  memory_tiering: PM: direct-complete suspend driver flags: 0
[  403.365945] workqueue writeback: PM: direct-complete suspend driver flags: 0
[  403.365950] dmi id: PM: direct-complete suspend driver flags: 0
[  403.365954] vtconsole vtcon0: PM: direct-complete suspend driver flags: 0
[  403.365959] regulator regulator.0: PM: class suspend driver flags: 0
[  403.365967]  workqueue: PM: direct-complete suspend driver flags: 0
[  403.365970]  container: PM: direct-complete suspend driver flags: 0
[  403.365975] processor cpu15: PM: direct-complete suspend driver flags: 0
[  403.365979] processor cpu14: PM: direct-complete suspend driver flags: 0
[  403.365983] processor cpu13: PM: direct-complete suspend driver flags: 0
[  403.365987] processor cpu12: PM: direct-complete suspend driver flags: 0
[  403.365992] processor cpu11: PM: direct-complete suspend driver flags: 0
[  403.365996] processor cpu10: PM: direct-complete suspend driver flags: 0
[  403.366000] processor cpu9: PM: direct-complete suspend driver flags: 0
[  403.366004] processor cpu8: PM: direct-complete suspend driver flags: 0
[  403.366008] processor cpu7: PM: direct-complete suspend driver flags: 0
[  403.366011] processor cpu6: PM: direct-complete suspend driver flags: 0
[  403.366015] processor cpu5: PM: direct-complete suspend driver flags: 0
[  403.366019] processor cpu4: PM: direct-complete suspend driver flags: 0
[  403.366023] processor cpu3: PM: direct-complete suspend driver flags: 0
[  403.366027] processor cpu2: PM: direct-complete suspend driver flags: 0
[  403.366031] processor cpu1: PM: direct-complete suspend driver flags: 0
[  403.366035] processor cpu0: PM: direct-complete suspend driver flags: 0
[  403.366039]  cpu: PM: direct-complete suspend driver flags: 0
[  403.366043] node node0: PM: direct-complete suspend driver flags: 0
[  403.366046]  node: PM: direct-complete suspend driver flags: 0
[  403.366050] memory memory131: PM: direct-complete suspend driver flags: 0
[  403.366054] memory memory130: PM: direct-complete suspend driver flags: 0
[  403.366058] memory memory129: PM: direct-complete suspend driver flags: 0
[  403.366061] memory memory128: PM: direct-complete suspend driver flags: 0
[  403.366064] memory memory127: PM: direct-complete suspend driver flags: 0
[  403.366068] memory memory126: PM: direct-complete suspend driver flags: 0
[  403.366071] memory memory125: PM: direct-complete suspend driver flags: 0
[  403.366075] memory memory124: PM: direct-complete suspend driver flags: 0
[  403.366079] memory memory123: PM: direct-complete suspend driver flags: 0
[  403.366082] memory memory122: PM: direct-complete suspend driver flags: 0
[  403.366086] memory memory121: PM: direct-complete suspend driver flags: 0
[  403.366090] memory memory120: PM: direct-complete suspend driver flags: 0
[  403.366093] memory memory119: PM: direct-complete suspend driver flags: 0
[  403.366097] memory memory118: PM: direct-complete suspend driver flags: 0
[  403.366100] memory memory117: PM: direct-complete suspend driver flags: 0
[  403.366104] memory memory116: PM: direct-complete suspend driver flags: 0
[  403.366107] memory memory115: PM: direct-complete suspend driver flags: 0
[  403.366111] memory memory114: PM: direct-complete suspend driver flags: 0
[  403.366114] memory memory113: PM: direct-complete suspend driver flags: 0
[  403.366118] memory memory112: PM: direct-complete suspend driver flags: 0
[  403.366121] memory memory111: PM: direct-complete suspend driver flags: 0
[  403.366125] memory memory110: PM: direct-complete suspend driver flags: 0
[  403.366129] memory memory109: PM: direct-complete suspend driver flags: 0
[  403.366132] memory memory108: PM: direct-complete suspend driver flags: 0
[  403.366136] memory memory107: PM: direct-complete suspend driver flags: 0
[  403.366139] memory memory106: PM: direct-complete suspend driver flags: 0
[  403.366159] memory memory105: PM: direct-complete suspend driver flags: 0
[  403.366162] memory memory104: PM: direct-complete suspend driver flags: 0
[  403.366166] memory memory103: PM: direct-complete suspend driver flags: 0
[  403.366170] memory memory102: PM: direct-complete suspend driver flags: 0
[  403.366173] memory memory101: PM: direct-complete suspend driver flags: 0
[  403.366177] memory memory100: PM: direct-complete suspend driver flags: 0
[  403.366180] memory memory99: PM: direct-complete suspend driver flags: 0
[  403.366184] memory memory98: PM: direct-complete suspend driver flags: 0
[  403.366188] memory memory97: PM: direct-complete suspend driver flags: 0
[  403.366191] memory memory96: PM: direct-complete suspend driver flags: 0
[  403.366195] memory memory95: PM: direct-complete suspend driver flags: 0
[  403.366198] memory memory94: PM: direct-complete suspend driver flags: 0
[  403.366202] memory memory93: PM: direct-complete suspend driver flags: 0
[  403.366205] memory memory92: PM: direct-complete suspend driver flags: 0
[  403.366209] memory memory91: PM: direct-complete suspend driver flags: 0
[  403.366213] memory memory90: PM: direct-complete suspend driver flags: 0
[  403.366217] memory memory89: PM: direct-complete suspend driver flags: 0
[  403.366222] memory memory88: PM: direct-complete suspend driver flags: 0
[  403.366227] memory memory87: PM: direct-complete suspend driver flags: 0
[  403.366233] memory memory86: PM: direct-complete suspend driver flags: 0
[  403.366237] memory memory85: PM: direct-complete suspend driver flags: 0
[  403.366241] memory memory84: PM: direct-complete suspend driver flags: 0
[  403.366244] memory memory83: PM: direct-complete suspend driver flags: 0
[  403.366247] memory memory82: PM: direct-complete suspend driver flags: 0
[  403.366251] memory memory81: PM: direct-complete suspend driver flags: 0
[  403.366254] memory memory80: PM: direct-complete suspend driver flags: 0
[  403.366258] memory memory79: PM: direct-complete suspend driver flags: 0
[  403.366261] memory memory78: PM: direct-complete suspend driver flags: 0
[  403.366265] memory memory77: PM: direct-complete suspend driver flags: 0
[  403.366269] memory memory76: PM: direct-complete suspend driver flags: 0
[  403.366272] memory memory75: PM: direct-complete suspend driver flags: 0
[  403.366276] memory memory74: PM: direct-complete suspend driver flags: 0
[  403.366279] memory memory73: PM: direct-complete suspend driver flags: 0
[  403.366283] memory memory72: PM: direct-complete suspend driver flags: 0
[  403.366286] memory memory71: PM: direct-complete suspend driver flags: 0
[  403.366290] memory memory70: PM: direct-complete suspend driver flags: 0
[  403.366293] memory memory69: PM: direct-complete suspend driver flags: 0
[  403.366297] memory memory68: PM: direct-complete suspend driver flags: 0
[  403.366301] memory memory67: PM: direct-complete suspend driver flags: 0
[  403.366304] memory memory66: PM: direct-complete suspend driver flags: 0
[  403.366308] memory memory65: PM: direct-complete suspend driver flags: 0
[  403.366311] memory memory64: PM: direct-complete suspend driver flags: 0
[  403.366317] memory memory63: PM: direct-complete suspend driver flags: 0
[  403.366331] memory memory62: PM: direct-complete suspend driver flags: 0
[  403.366334] memory memory61: PM: direct-complete suspend driver flags: 0
[  403.366338] memory memory60: PM: direct-complete suspend driver flags: 0
[  403.366341] memory memory59: PM: direct-complete suspend driver flags: 0
[  403.366345] memory memory58: PM: direct-complete suspend driver flags: 0
[  403.366348] memory memory57: PM: direct-complete suspend driver flags: 0
[  403.366352] memory memory56: PM: direct-complete suspend driver flags: 0
[  403.366356] memory memory55: PM: direct-complete suspend driver flags: 0
[  403.366359] memory memory54: PM: direct-complete suspend driver flags: 0
[  403.366363] memory memory53: PM: direct-complete suspend driver flags: 0
[  403.366367] memory memory52: PM: direct-complete suspend driver flags: 0
[  403.366370] memory memory51: PM: direct-complete suspend driver flags: 0
[  403.366374] memory memory50: PM: direct-complete suspend driver flags: 0
[  403.366377] memory memory49: PM: direct-complete suspend driver flags: 0
[  403.366381] memory memory48: PM: direct-complete suspend driver flags: 0
[  403.366384] memory memory47: PM: direct-complete suspend driver flags: 0
[  403.366388] memory memory46: PM: direct-complete suspend driver flags: 0
[  403.366391] memory memory45: PM: direct-complete suspend driver flags: 0
[  403.366395] memory memory44: PM: direct-complete suspend driver flags: 0
[  403.366398] memory memory43: PM: direct-complete suspend driver flags: 0
[  403.366402] memory memory42: PM: direct-complete suspend driver flags: 0
[  403.366406] memory memory41: PM: direct-complete suspend driver flags: 0
[  403.366410] memory memory40: PM: direct-complete suspend driver flags: 0
[  403.366413] memory memory39: PM: direct-complete suspend driver flags: 0
[  403.366416] memory memory38: PM: direct-complete suspend driver flags: 0
[  403.366420] memory memory37: PM: direct-complete suspend driver flags: 0
[  403.366424] memory memory36: PM: direct-complete suspend driver flags: 0
[  403.366427] memory memory35: PM: direct-complete suspend driver flags: 0
[  403.366431] memory memory34: PM: direct-complete suspend driver flags: 0
[  403.366437] memory memory33: PM: direct-complete suspend driver flags: 0
[  403.366440] memory memory32: PM: direct-complete suspend driver flags: 0
[  403.366445] memory memory23: PM: direct-complete suspend driver flags: 0
[  403.366448] memory memory22: PM: direct-complete suspend driver flags: 0
[  403.366452] memory memory21: PM: direct-complete suspend driver flags: 0
[  403.366456] memory memory20: PM: direct-complete suspend driver flags: 0
[  403.366459] memory memory19: PM: direct-complete suspend driver flags: 0
[  403.366462] memory memory18: PM: direct-complete suspend driver flags: 0
[  403.366466] memory memory17: PM: direct-complete suspend driver flags: 0
[  403.366469] memory memory16: PM: direct-complete suspend driver flags: 0
[  403.366473] memory memory15: PM: direct-complete suspend driver flags: 0
[  403.366476] memory memory14: PM: direct-complete suspend driver flags: 0
[  403.366480] memory memory13: PM: direct-complete suspend driver flags: 0
[  403.366483] memory memory12: PM: direct-complete suspend driver flags: 0
[  403.366487] memory memory11: PM: direct-complete suspend driver flags: 0
[  403.366490] memory memory10: PM: direct-complete suspend driver flags: 0
[  403.366494] memory memory9: PM: direct-complete suspend driver flags: 0
[  403.366497] memory memory8: PM: direct-complete suspend driver flags: 0
[  403.366501] memory memory7: PM: direct-complete suspend driver flags: 0
[  403.366504] memory memory6: PM: direct-complete suspend driver flags: 0
[  403.366508] memory memory5: PM: direct-complete suspend driver flags: 0
[  403.366512] memory memory4: PM: direct-complete suspend driver flags: 0
[  403.366515] memory memory3: PM: direct-complete suspend driver flags: 0
[  403.366519] memory memory2: PM: direct-complete suspend driver flags: 0
[  403.366522] memory memory1: PM: direct-complete suspend driver flags: 0
[  403.366526] memory memory0: PM: direct-complete suspend driver flags: 0
[  403.366529]  memory: PM: direct-complete suspend driver flags: 0
[  403.371095] iwlwifi 0000:01:00.0: PM: bus suspend driver flags: 0
[  403.371157] pcieport 0000:00:02.2: PM: bus suspend driver flags: 5
[  403.380973] usb usb4: PM: type suspend driver flags: 0
[  403.417165] pcieport 0000:00:02.4: PM: bus suspend driver flags: 5
[  403.427133] usb usb3: PM: type suspend driver flags: 0
[  403.435905] xhci_hcd 0000:03:00.4: PM: bus suspend, may wakeup driver flags: 0
[  403.436142] pcieport 0000:00:08.1: PM: bus suspend, may wakeup driver flags: 5
[  403.436237] PM: suspend of devices complete after 136.830 msecs
[  403.436251] PM: start suspend of devices complete after 391.853 msecs
[  403.437437] pcie_mp2_amd 0000:03:00.7: PM: late bus suspend driver flags: 0
[  403.437438] ccp 0000:03:00.2: PM: late bus suspend driver flags: 0
[  403.437440] pci 0000:00:18.7: PM: late bus suspend driver flags: 0
[  403.437441] pci 0000:00:18.6: PM: late bus suspend driver flags: 0
[  403.437442] pci 0000:00:18.5: PM: late bus suspend driver flags: 0
[  403.437443] pci 0000:00:18.4: PM: late bus suspend driver flags: 0
[  403.437444] pci 0000:00:18.2: PM: late bus suspend driver flags: 0
[  403.437445] pci 0000:00:18.0: PM: late bus suspend driver flags: 0
[  403.437445] pci 0000:00:18.1: PM: late bus suspend driver flags: 0
[  403.437449] pci 0000:00:08.0: PM: late bus suspend driver flags: 0
[  403.437450] pci 0000:00:02.0: PM: late bus suspend driver flags: 0
[  403.437453] pci 0000:00:00.0: PM: late bus suspend driver flags: 0
[  403.437454] pci 0000:00:01.0: PM: late bus suspend driver flags: 0
[  403.437884] iwlwifi 0000:01:00.0: PM: late bus suspend driver flags: 0
[  403.437923] snd_hda_intel 0000:03:00.6: PM: late bus suspend driver flags: 0
[  403.437937] snd_hda_intel 0000:03:00.1: PM: late bus suspend driver flags: 0
[  403.437976] xhci_hcd 0000:03:00.3: PM: late bus suspend, may wakeup driver flags: 0
[  403.438014] snd_rn_pci_acp3x 0000:03:00.5: PM: late bus suspend driver flags: 0
[  403.438023] k10temp 0000:00:18.3: PM: late bus suspend driver flags: 0
[  403.438040] piix4_smbus 0000:00:14.0: PM: late bus suspend driver flags: 0
[  403.438149] amdgpu 0000:03:00.0: PM: late bus suspend driver flags: 0
[  403.438165] i2c_hid_acpi i2c-ELAN074E:00: PM: late power domain suspend, may wakeup driver flags: 0
[  403.438183] nvme 0000:02:00.0: PM: late bus suspend driver flags: 0
[  403.438194] xhci_hcd 0000:03:00.4: PM: late bus suspend, may wakeup driver flags: 0
[  403.438220] i2c_designware AMDI0010:03: PM: late power domain suspend driver flags: 6
[  403.438413] pci 0000:00:00.2: PM: late bus suspend driver flags: 0
[  403.438543] acpi-wmi PNP0C14:04: PM: late power domain suspend driver flags: 0
[  403.438552] amd_pmc AMDI0005:00: PM: late power domain suspend driver flags: 0
[  403.438557] ucsi_acpi USBC000:00: PM: late power domain suspend driver flags: 0
[  403.438564] acpi-wmi PNP0C14:03: PM: late power domain suspend driver flags: 0
[  403.438571] acpi-wmi PNP0C14:02: PM: late power domain suspend driver flags: 0
[  403.438575] acpi-wmi PNP0C14:01: PM: late power domain suspend driver flags: 0
[  403.438580] acpi-wmi PNP0C14:00: PM: late power domain suspend driver flags: 0
[  403.438585] amd_gpio AMDI0030:00: PM: late power domain suspend driver flags: 0
[  403.438611] Disabling GPIO #9 interrupt for suspend.
[  403.438656] ac ACPI0003:00: PM: late power domain suspend driver flags: 0
[  403.438670] pci 0000:00:14.3: PM: late bus suspend driver flags: 0
[  403.438684] pcieport 0000:00:02.4: PM: late bus suspend driver flags: 5
[  403.438685] pcieport 0000:00:02.2: PM: late bus suspend driver flags: 5
[  403.438698] pcieport 0000:00:08.1: PM: late bus suspend, may wakeup driver flags: 5
[  403.439175] PM: late suspend of devices complete after 2.917 msecs
[  403.440346] pcie_mp2_amd 0000:03:00.7: PM: noirq bus suspend driver flags: 0
[  403.440347] ccp 0000:03:00.2: PM: noirq bus suspend driver flags: 0
[  403.440350] pci 0000:00:18.7: PM: noirq bus suspend driver flags: 0
[  403.440351] pci 0000:00:18.5: PM: noirq bus suspend driver flags: 0
[  403.440351] pci 0000:00:18.6: PM: noirq bus suspend driver flags: 0
[  403.440351] pci 0000:00:18.4: PM: noirq bus suspend driver flags: 0
[  403.440353] pci 0000:00:18.2: PM: noirq bus suspend driver flags: 0
[  403.440355] pci 0000:00:18.0: PM: noirq bus suspend driver flags: 0
[  403.440355] pci 0000:00:18.1: PM: noirq bus suspend driver flags: 0
[  403.440359] pci 0000:00:08.0: PM: noirq bus suspend driver flags: 0
[  403.440360] pci 0000:00:02.0: PM: noirq bus suspend driver flags: 0
[  403.440362] pci 0000:00:01.0: PM: noirq bus suspend driver flags: 0
[  403.440363] pci 0000:00:00.0: PM: noirq bus suspend driver flags: 0
[  403.440491] snd_hda_intel 0000:03:00.1: PM: noirq bus suspend driver flags: 0
[  403.440533] iwlwifi 0000:01:00.0: PM: noirq bus suspend driver flags: 0
[  403.440545] snd_hda_intel 0000:03:00.6: PM: noirq bus suspend driver flags: 0
[  403.440545] xhci_hcd 0000:03:00.3: PM: noirq bus suspend, may wakeup driver flags: 0
[  403.440546] snd_rn_pci_acp3x 0000:03:00.5: PM: noirq bus suspend driver flags: 0
[  403.440595] k10temp 0000:00:18.3: PM: noirq bus suspend driver flags: 0
[  403.440809] piix4_smbus 0000:00:14.0: PM: noirq bus suspend driver flags: 0
[  403.440810] nvme 0000:02:00.0: PM: noirq bus suspend driver flags: 0
[  403.440817] i2c_hid_acpi i2c-ELAN074E:00: PM: noirq power domain suspend, may wakeup driver flags: 0
[  403.440827] xhci_hcd 0000:03:00.4: PM: noirq bus suspend, may wakeup driver flags: 0
[  403.441022] i2c_designware AMDI0010:03: PM: noirq power domain suspend driver flags: 6
[  403.441118] pci 0000:00:00.2: PM: noirq bus suspend driver flags: 0
[  403.441232] acpi-wmi PNP0C14:04: PM: noirq power domain suspend driver flags: 0
[  403.441240] amd_pmc AMDI0005:00: PM: noirq power domain suspend driver flags: 0
[  403.441244] ucsi_acpi USBC000:00: PM: noirq power domain suspend driver flags: 0
[  403.441250] acpi-wmi PNP0C14:03: PM: noirq power domain suspend driver flags: 0
[  403.441255] acpi-wmi PNP0C14:02: PM: noirq power domain suspend driver flags: 0
[  403.441259] acpi-wmi PNP0C14:01: PM: noirq power domain suspend driver flags: 0
[  403.441263] acpi-wmi PNP0C14:00: PM: noirq power domain suspend driver flags: 0
[  403.441269] amd_gpio AMDI0030:00: PM: noirq power domain suspend driver flags: 0
[  403.441279] ac ACPI0003:00: PM: noirq power domain suspend driver flags: 0
[  403.441292] pci 0000:00:14.3: PM: noirq bus suspend driver flags: 0
[  403.441475] ec PNP0C09:00: PM: noirq driver suspend driver flags: 0
[  403.441487] ACPI: EC: interrupt blocked
[  403.452537] amdgpu 0000:03:00.0: PM: noirq bus suspend driver flags: 0
[  403.463904] amdgpu 0000:03:00.0: Refused to change power state from D0 to D3hot
[  403.468314] pcieport 0000:00:02.4: PM: noirq bus suspend driver flags: 5
[  403.468328] pcieport 0000:00:02.2: PM: noirq bus suspend driver flags: 5
[  403.480581] pcieport 0000:00:08.1: PM: noirq bus suspend, may wakeup driver flags: 5
[  403.480657] PM: noirq suspend of devices complete after 40.999 msecs
[  403.480698] ACPI: \_SB_.PLTF.P000: LPI: Device not power manageable
[  403.480701] ACPI: \_SB_.PLTF.P001: LPI: Device not power manageable
[  403.480704] ACPI: \_SB_.PLTF.P002: LPI: Device not power manageable
[  403.480706] ACPI: \_SB_.PLTF.P003: LPI: Device not power manageable
[  403.480708] ACPI: \_SB_.PLTF.P004: LPI: Device not power manageable
[  403.480710] ACPI: \_SB_.PLTF.P005: LPI: Device not power manageable
[  403.480712] ACPI: \_SB_.PLTF.P006: LPI: Device not power manageable
[  403.480714] ACPI: \_SB_.PLTF.P007: LPI: Device not power manageable
[  403.480716] ACPI: \_SB_.PLTF.P008: LPI: Device not power manageable
[  403.480718] ACPI: \_SB_.PLTF.P009: LPI: Device not power manageable
[  403.480720] ACPI: \_SB_.PLTF.P00A: LPI: Device not power manageable
[  403.480722] ACPI: \_SB_.PLTF.P00B: LPI: Device not power manageable
[  403.480724] ACPI: \_SB_.PLTF.P00C: LPI: Device not power manageable
[  403.480726] ACPI: \_SB_.PLTF.P00D: LPI: Device not power manageable
[  403.480728] ACPI: \_SB_.PLTF.P00E: LPI: Device not power manageable
[  403.480730] ACPI: \_SB_.PLTF.P00F: LPI: Device not power manageable
[  403.480732] ACPI: \_SB_.PCI0.GPP1: LPI: Device not power manageable
[  403.480733] ACPI: \_SB_.PCI0.GPP4: LPI: Device not power manageable
[  403.480736] ACPI: \_SB_.PCI0.GPP4.XPDV: LPI: Device not power manageable
[  403.480738] ACPI: \_SB_.PCI0.GPP6.NVME: LPI: Device not power manageable
[  403.480739] ACPI: \_SB_.PCI0.GP17.VGA_: LPI: Device not power manageable
[  403.480743] ACPI: \_SB_.PCI0.GP17.HDAU: LPI: Device not power manageable
[  403.480746] ACPI: \_SB_.PCI0.GP17.XHC1.RHUB.PRT3.BUTH: LPI: Device not power manageable
[  403.480884] ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
[  403.489755] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
[  403.490072] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
[  403.583473] PM: suspend-to-idle
[  403.583530] amd_pmc: SMU idlemask s0i3: 0xc02e0eb5
[  407.417240] Timekeeping suspended for 3.751 seconds
[  407.420025] PM: Triggering wakeup from IRQ 9
[  407.420286] PM: Triggering wakeup from IRQ 1
[  407.420295] PM: Triggering wakeup from IRQ 0
[  407.420591] ACPI: EC: ACPI EC GPE status set
[  407.420775] ACPI: EC: ACPI EC GPE dispatched
[  407.421269] ACPI: EC: ACPI EC work flushed
[  407.422323] ACPI: PM: Wakeup after ACPI Notify sync
[  407.422326] PM: resume from suspend-to-idle
[  407.423429] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
[  407.428296] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
[  407.429699] ACPI: \_SB_.PEP_: Successfully transitioned to state screen on
[  407.430358] pci 0000:00:00.0: PM: noirq bus resume driver flags: 0
[  407.430360] i2c_designware AMDI0010:03: PM: noirq power domain resume driver flags: 6
[  407.430360] pci 0000:00:00.2: PM: noirq bus resume driver flags: 0
[  407.430388] pci 0000:00:01.0: PM: noirq bus resume driver flags: 0
[  407.430404] pci 0000:00:02.0: PM: noirq bus resume driver flags: 0
[  407.430438] pcieport 0000:00:02.2: PM: noirq bus resume driver flags: 5
[  407.430505] pcieport 0000:00:02.4: PM: noirq bus resume driver flags: 5
[  407.430514] pci 0000:00:08.0: PM: noirq bus resume driver flags: 0
[  407.430569] piix4_smbus 0000:00:14.0: PM: noirq bus resume driver flags: 0
[  407.430570] pci 0000:00:14.3: PM: noirq bus resume driver flags: 0
[  407.430570] pcieport 0000:00:08.1: PM: noirq bus resume driver flags: 5
[  407.430570] pci 0000:00:18.0: PM: noirq bus resume driver flags: 0
[  407.430574] pci 0000:00:18.1: PM: noirq bus resume driver flags: 0
[  407.430668] pci 0000:00:18.2: PM: noirq bus resume driver flags: 0
[  407.430669] k10temp 0000:00:18.3: PM: noirq bus resume driver flags: 0
[  407.430675] pci 0000:00:18.4: PM: noirq bus resume driver flags: 0
[  407.430704] pci 0000:00:18.5: PM: noirq bus resume driver flags: 0
[  407.430722] pci 0000:00:18.6: PM: noirq bus resume driver flags: 0
[  407.430723] pci 0000:00:18.7: PM: noirq bus resume driver flags: 0
[  407.430728] amdgpu 0000:03:00.0: PM: noirq bus resume driver flags: 0
[  407.430730] ccp 0000:03:00.2: PM: noirq bus resume driver flags: 0
[  407.430737] xhci_hcd 0000:03:00.3: PM: noirq bus resume driver flags: 0
[  407.430747] snd_hda_intel 0000:03:00.1: PM: noirq bus resume driver flags: 0
[  407.430775] xhci_hcd 0000:03:00.4: PM: noirq bus resume driver flags: 0
[  407.430785] snd_hda_intel 0000:03:00.6: PM: noirq bus resume driver flags: 0
[  407.430784] snd_rn_pci_acp3x 0000:03:00.5: PM: noirq bus resume driver flags: 0
[  407.430785] pcie_mp2_amd 0000:03:00.7: PM: noirq bus resume driver flags: 0
[  407.430854] i2c_hid_acpi i2c-ELAN074E:00: PM: noirq power domain resume driver flags: 0
[  407.430957] ec PNP0C09:00: PM: noirq driver resume driver flags: 0
[  407.430959] ACPI: EC: interrupt unblocked
[  407.431111] ac ACPI0003:00: PM: noirq power domain resume driver flags: 0
[  407.431120] amd_gpio AMDI0030:00: PM: noirq power domain resume driver flags: 0
[  407.431125] acpi-wmi PNP0C14:00: PM: noirq power domain resume driver flags: 0
[  407.431129] acpi-wmi PNP0C14:01: PM: noirq power domain resume driver flags: 0
[  407.431133] acpi-wmi PNP0C14:02: PM: noirq power domain resume driver flags: 0
[  407.431139] acpi-wmi PNP0C14:03: PM: noirq power domain resume driver flags: 0
[  407.431145] ucsi_acpi USBC000:00: PM: noirq power domain resume driver flags: 0
[  407.431150] amd_pmc AMDI0005:00: PM: noirq power domain resume driver flags: 0
[  407.431159] acpi-wmi PNP0C14:04: PM: noirq power domain resume driver flags: 0
[  407.431444] i8042 i8042: PM: noirq driver resume driver flags: 0
[  407.442522] iwlwifi 0000:01:00.0: PM: noirq bus resume driver flags: 0
[  407.442718] nvme 0000:02:00.0: PM: noirq bus resume driver flags: 0
[  407.461114] PM: noirq resume of devices complete after 31.409 msecs
[  407.461223] GPIO 0 is active: 0x300578e3
[  407.462055] pci 0000:00:00.0: PM: early bus resume driver flags: 0
[  407.462076] pci 0000:00:00.2: PM: early bus resume driver flags: 0
[  407.462078] pci 0000:00:01.0: PM: early bus resume driver flags: 0
[  407.462080] pci 0000:00:02.0: PM: early bus resume driver flags: 0
[  407.462086] pcieport 0000:00:02.2: PM: early bus resume driver flags: 5
[  407.462088] pcieport 0000:00:02.4: PM: early bus resume driver flags: 5
[  407.462089] pci 0000:00:08.0: PM: early bus resume driver flags: 0
[  407.462114] pci 0000:00:14.3: PM: early bus resume driver flags: 0
[  407.462114] piix4_smbus 0000:00:14.0: PM: early bus resume driver flags: 0
[  407.462115] pci 0000:00:18.1: PM: early bus resume driver flags: 0
[  407.462115] pcieport 0000:00:08.1: PM: early bus resume driver flags: 5
[  407.462116] pci 0000:00:18.0: PM: early bus resume driver flags: 0
[  407.462153] pci 0000:00:18.2: PM: early bus resume driver flags: 0
[  407.462154] pci 0000:00:18.4: PM: early bus resume driver flags: 0
[  407.462154] k10temp 0000:00:18.3: PM: early bus resume driver flags: 0
[  407.462156] pci 0000:00:18.6: PM: early bus resume driver flags: 0
[  407.462156] pci 0000:00:18.5: PM: early bus resume driver flags: 0
[  407.462157] pci 0000:00:18.7: PM: early bus resume driver flags: 0
[  407.462160] iwlwifi 0000:01:00.0: PM: early bus resume driver flags: 0
[  407.462161] i2c_designware AMDI0010:03: PM: early power domain resume driver flags: 6
[  407.462166] nvme 0000:02:00.0: PM: early bus resume driver flags: 0
[  407.462174] amdgpu 0000:03:00.0: PM: early bus resume driver flags: 0
[  407.462174] xhci_hcd 0000:03:00.4: PM: early bus resume driver flags: 0
[  407.462186] xhci_hcd 0000:03:00.3: PM: early bus resume driver flags: 0
[  407.462187] ccp 0000:03:00.2: PM: early bus resume driver flags: 0
[  407.462187] snd_hda_intel 0000:03:00.1: PM: early bus resume driver flags: 0
[  407.462187] snd_rn_pci_acp3x 0000:03:00.5: PM: early bus resume driver flags: 0
[  407.462207] snd_hda_intel 0000:03:00.6: PM: early bus resume driver flags: 0
[  407.462227] pcie_mp2_amd 0000:03:00.7: PM: early bus resume driver flags: 0
[  407.462344] i2c_hid_acpi i2c-ELAN074E:00: PM: early power domain resume driver flags: 0
[  407.463011] ac ACPI0003:00: PM: early power domain resume driver flags: 0
[  407.463023] amd_gpio AMDI0030:00: PM: early power domain resume driver flags: 0
[  407.463078] acpi-wmi PNP0C14:00: PM: early power domain resume driver flags: 0
[  407.463082] acpi-wmi PNP0C14:01: PM: early power domain resume driver flags: 0
[  407.463086] acpi-wmi PNP0C14:02: PM: early power domain resume driver flags: 0
[  407.463091] acpi-wmi PNP0C14:03: PM: early power domain resume driver flags: 0
[  407.463096] ucsi_acpi USBC000:00: PM: early power domain resume driver flags: 0
[  407.463100] amd_pmc AMDI0005:00: PM: early power domain resume driver flags: 0
[  407.463107] acpi-wmi PNP0C14:04: PM: early power domain resume driver flags: 0
[  407.463658] PM: early resume of devices complete after 1.872 msecs
[  407.463779] pci 0000:00:00.0: PM: bus resume driver flags: 0
[  407.463790] pci 0000:00:00.2: PM: bus resume driver flags: 0
[  407.463793] pci 0000:00:01.0: PM: bus resume driver flags: 0
[  407.463803] pci 0000:00:02.0: PM: bus resume driver flags: 0
[  407.463805] pcieport 0000:00:02.2: PM: bus resume driver flags: 5
[  407.463810] pcieport 0000:00:02.4: PM: bus resume driver flags: 5
[  407.463848] pci 0000:00:08.0: PM: bus resume driver flags: 0
[  407.463849] pcieport 0000:00:08.1: PM: bus resume driver flags: 5
[  407.463855] piix4_smbus 0000:00:14.0: PM: bus resume driver flags: 0
[  407.463870] pci 0000:00:14.3: PM: bus resume driver flags: 0
[  407.463879] pci 0000:00:18.0: PM: bus resume driver flags: 0
[  407.463887] pci 0000:00:18.1: PM: bus resume driver flags: 0
[  407.463895] pci 0000:00:18.2: PM: bus resume driver flags: 0
[  407.463903] k10temp 0000:00:18.3: PM: bus resume driver flags: 0
[  407.463912] pci 0000:00:18.4: PM: bus resume driver flags: 0
[  407.463920] pci 0000:00:18.5: PM: bus resume driver flags: 0
[  407.463928] pci 0000:00:18.6: PM: bus resume driver flags: 0
[  407.463936] pci 0000:00:18.7: PM: bus resume driver flags: 0
[  407.463963] i2c_designware AMDI0010:03: PM: power domain resume driver flags: 6
[  407.463964] iwlwifi 0000:01:00.0: PM: bus resume driver flags: 0
[  407.463982] nvme 0000:02:00.0: PM: bus resume driver flags: 0
[  407.464004] regulator regulator.0: PM: class resume driver flags: 0
[  407.464022] amdgpu 0000:03:00.0: PM: bus resume driver flags: 0
[  407.464137] ec PNP0C09:00: PM: driver resume driver flags: 0
[  407.464194] ccp 0000:03:00.2: PM: bus resume driver flags: 0
[  407.464206] xhci_hcd 0000:03:00.3: PM: bus resume driver flags: 0
[  407.464223] xhci_hcd 0000:03:00.4: PM: bus resume driver flags: 0
[  407.464264] battery PNP0C0A:00: PM: driver resume driver flags: 0
[  407.464264] snd_hda_intel 0000:03:00.6: PM: bus resume driver flags: 0
[  407.464264] snd_rn_pci_acp3x 0000:03:00.5: PM: bus resume driver flags: 0
[  407.464274] pcie_mp2_amd 0000:03:00.7: PM: bus resume driver flags: 0
[  407.464326] ieee80211 phy0: PM: class resume driver flags: 0
[  407.464326] i2c_hid_acpi i2c-ELAN074E:00: PM: power domain resume driver flags: 0
[  407.464341] usb usb1: PM: type resume driver flags: 0
[  407.464345] usb usb2: PM: type resume driver flags: 0
[  407.464446] usb usb3: PM: type resume driver flags: 0
[  407.464459] usb usb4: PM: type resume driver flags: 0
[  407.464533] usb 1-3: PM: type resume driver flags: 0
[  407.464548] usb 1-4: PM: type resume driver flags: 0
[  407.465140] button PNP0C0C:00: PM: driver resume driver flags: 0
[  407.467366] tpm_crb MSFT0101:00: PM: driver resume driver flags: 0
[  407.467375] button PNP0C0D:00: PM: driver resume driver flags: 0
[  407.467548] thermal LNXTHERM:00: PM: driver resume driver flags: 0
[  407.467609] snd_hda_codec_realtek hdaudioC1D0: PM: driver resume driver flags: 0
[  407.469013] thermal LNXTHERM:01: PM: driver resume driver flags: 0
[  407.469038] platform PNP0800:00: PM: bus resume driver flags: 0
[  407.469042] platform PNP0C09:00: PM: bus resume driver flags: 0
[  407.469046] ac ACPI0003:00: PM: power domain resume driver flags: 0
[  407.472126] platform PNP0C0A:00: PM: bus resume driver flags: 0
[  407.472131] platform HPIC0003:00: PM: bus resume driver flags: 0
[  407.472134] platform PNP0C0C:00: PM: bus resume driver flags: 0
[  407.472137] platform acpi-cpufreq: PM: bus resume driver flags: 0
[  407.472139] amd_gpio AMDI0030:00: PM: power domain resume driver flags: 0
[  407.472144] platform MSFT0101:00: PM: bus resume driver flags: 0
[  407.472146] acpi-wmi PNP0C14:00: PM: power domain resume driver flags: 0
[  407.472149] acpi-wmi PNP0C14:01: PM: power domain resume driver flags: 0
[  407.472152] acpi-wmi PNP0C14:02: PM: power domain resume driver flags: 0
[  407.472155] platform PNP0C0D:00: PM: bus resume driver flags: 0
[  407.472158] acpi-wmi PNP0C14:03: PM: power domain resume driver flags: 0
[  407.472161] platform ACPI000E:00: PM: bus resume driver flags: 0
[  407.472163] ucsi_acpi USBC000:00: PM: power domain resume driver flags: 0
[  407.472245] amd_pmc AMDI0005:00: PM: power domain resume driver flags: 0
[  407.472252] acpi-fan PNP0C0B:00: PM: bus resume driver flags: 0
[  407.472264] platform PNP0103:00: PM: bus resume driver flags: 0
[  407.472269] acpi-wmi PNP0C14:04: PM: power domain resume driver flags: 0
[  407.472282] platform rtc-efi.0: PM: bus resume driver flags: 0
[  407.472287] platform efivars.0: PM: bus resume driver flags: 0
[  407.472301] system 00:00: PM: bus resume driver flags: 0
[  407.472307] rtc_cmos 00:01: PM: bus resume driver flags: 0
[  407.472315] i8042 kbd 00:02: PM: bus resume driver flags: 0
[  407.472319] system 00:03: PM: bus resume driver flags: 0
[  407.472477] pcspkr pcspkr: PM: bus resume driver flags: 0
[  407.475703] serial8250 serial8250: PM: bus resume driver flags: 0
[  407.475712] port serial8250:0.0: PM: driver resume driver flags: 0
[  407.475717] port serial8250:0.1: PM: driver resume driver flags: 0
[  407.475721] port serial8250:0.2: PM: driver resume driver flags: 0
[  407.475725] port serial8250:0.3: PM: driver resume driver flags: 0
[  407.475733] i8042 i8042: PM: bus resume driver flags: 0
[  407.475739] atkbd serio0: PM: bus resume driver flags: 0
[  407.476603] rtc rtc0: PM: class resume driver flags: 0
[  407.476638] alarmtimer alarmtimer.0.auto: PM: bus resume driver flags: 0
[  407.476767] input input0: PM: type resume driver flags: 0
[  407.477241] leds input0::numlock: PM: class resume driver flags: 0
[  407.477245] leds input0::capslock: PM: class resume driver flags: 0
[  407.477247] leds input0::scrolllock: PM: class resume driver flags: 0
[  407.477263] platform microcode: PM: bus resume driver flags: 0
[  407.477283] input input1: PM: type resume driver flags: 0
[  407.477295] input input2: PM: type resume driver flags: 0
[  407.477300] input input3: PM: type resume driver flags: 0
[  407.478035] [drm] PCIE GART of 1024M enabled.
[  407.478036] [drm] PTB located at 0x000000F41FC00000
[  407.478137] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  407.480075] amdgpu 0000:03:00.0: amdgpu: dpm has been disabled
[  407.481195] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[  407.489651] usb 4-1: PM: type resume driver flags: 0
[  407.519467] usb 3-3: PM: type resume driver flags: 0
[  407.529987] input input7: PM: type resume driver flags: 0
[  407.530001] input input9: PM: type resume driver flags: 0
[  407.568705] scsi host0: PM: bus resume driver flags: 0
[  407.568732] scsi target0:0:0: PM: bus resume driver flags: 0
[  407.568750] sd 0:0:0:0: PM: bus resume driver flags: 0
[  407.594691] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[  407.594695] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  407.594697] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  407.594699] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[  407.594700] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[  407.594702] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[  407.594703] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[  407.594704] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[  407.594706] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[  407.594707] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
[  407.594708] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
[  407.594710] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
[  407.594711] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
[  407.594712] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
[  407.594714] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
[  407.607502] snd_hda_intel 0000:03:00.1: PM: bus resume driver flags: 0
[  407.607520] backlight amdgpu_bl0: PM: class resume driver flags: 0
[  407.607720] input input10: PM: type resume driver flags: 0
[  407.607759] sp5100-tco sp5100-tco: PM: bus resume driver flags: 0
[  407.607772] platform regulatory.0: PM: bus resume driver flags: 0
[  407.607784] acp_rn_pdm_dma acp_rn_pdm_dma.0: PM: bus resume driver flags: 0
[  407.607790] dmic-codec dmic-codec.0: PM: bus resume driver flags: 0
[  407.607794] input input11: PM: type resume driver flags: 0
[  407.607801] hp-wmi hp-wmi: PM: bus resume driver flags: 0
[  407.608644] rfkill rfkill0: PM: class resume driver flags: 0
[  407.608790] intel_rapl_msr intel_rapl_msr.0: PM: bus resume driver flags: 0
[  407.609503] input input12: PM: type resume driver flags: 0
[  407.609520] leds hda::mute: PM: class resume driver flags: 0
[  407.609543] input input13: PM: type resume driver flags: 0
[  407.609548] input input14: PM: type resume driver flags: 0
[  407.609556] acp_pdm_mach acp_pdm_mach.0: PM: bus resume driver flags: 0
[  407.609665] leds phy0-led: PM: class resume driver flags: 0
[  407.609669] rfkill rfkill1: PM: class resume driver flags: 0
[  407.609710] PM: resume of devices complete after 146.048 msecs
[  407.609894] snd_hda_codec_realtek hdaudioC1D0: PM: completing driver resume driver flags: 0
[  407.609924] snd_hda_codec_hdmi hdaudioC0D0: PM: completing driver resume driver flags: 0
[  407.609983] usb 4-1: PM: completing type resume driver flags: 0
[  407.610006] usb 1-4: PM: completing type resume driver flags: 0
[  407.610029] usb 3-3: PM: completing type resume driver flags: 0
[  407.610034] usb 1-3: PM: completing type resume driver flags: 0
[  407.610045] usb usb4: PM: completing type resume driver flags: 0
[  407.610053] usb usb3: PM: completing type resume driver flags: 0
[  407.610062] usb usb2: PM: completing type resume driver flags: 0
[  407.610072] usb usb1: PM: completing type resume driver flags: 0
[  407.610181] snd_hda_intel 0000:03:00.1: PM: completing bus resume driver flags: 0
[  407.610229] i2c_hid_acpi i2c-ELAN074E:00: PM: completing power domain resume driver flags: 0
[  407.610242] acpi-wmi PNP0C14:04: PM: completing power domain resume driver flags: 0
[  407.610244] amd_pmc AMDI0005:00: PM: completing power domain resume driver flags: 0
[  407.610246] ucsi_acpi USBC000:00: PM: completing power domain resume driver flags: 0
[  407.610248] acpi-wmi PNP0C14:03: PM: completing power domain resume driver flags: 0
[  407.610249] acpi-wmi PNP0C14:02: PM: completing power domain resume driver flags: 0
[  407.610251] acpi-wmi PNP0C14:01: PM: completing power domain resume driver flags: 0
[  407.610252] acpi-wmi PNP0C14:00: PM: completing power domain resume driver flags: 0
[  407.610254] i2c_designware AMDI0010:03: PM: completing power domain resume driver flags: 6
[  407.610318] amd_gpio AMDI0030:00: PM: completing power domain resume driver flags: 0
[  407.610321] ac ACPI0003:00: PM: completing power domain resume driver flags: 0
[  407.610323] pcie_mp2_amd 0000:03:00.7: PM: completing bus resume driver flags: 0
[  407.610325] snd_hda_intel 0000:03:00.6: PM: completing bus resume driver flags: 0
[  407.610328] snd_rn_pci_acp3x 0000:03:00.5: PM: completing bus resume driver flags: 0
[  407.610330] xhci_hcd 0000:03:00.4: PM: completing bus resume driver flags: 0
[  407.610412] xhci_hcd 0000:03:00.3: PM: completing bus resume driver flags: 0
[  407.610479] ccp 0000:03:00.2: PM: completing bus resume driver flags: 0
[  407.610481] amdgpu 0000:03:00.0: PM: completing bus resume driver flags: 0
[  407.610484] nvme 0000:02:00.0: PM: completing bus resume driver flags: 0
[  407.610486] iwlwifi 0000:01:00.0: PM: completing bus resume driver flags: 0
[  407.610488] pci 0000:00:18.7: PM: completing bus resume driver flags: 0
[  407.610489] pci 0000:00:18.6: PM: completing bus resume driver flags: 0
[  407.610490] pci 0000:00:18.5: PM: completing bus resume driver flags: 0
[  407.610491] pci 0000:00:18.4: PM: completing bus resume driver flags: 0
[  407.610493] k10temp 0000:00:18.3: PM: completing bus resume driver flags: 0
[  407.610494] pci 0000:00:18.2: PM: completing bus resume driver flags: 0
[  407.610495] pci 0000:00:18.1: PM: completing bus resume driver flags: 0
[  407.610496] pci 0000:00:18.0: PM: completing bus resume driver flags: 0
[  407.610498] pci 0000:00:14.3: PM: completing bus resume driver flags: 0
[  407.610499] piix4_smbus 0000:00:14.0: PM: completing bus resume driver flags: 0
[  407.610500] pcieport 0000:00:08.1: PM: completing bus resume driver flags: 5
[  407.610502] pci 0000:00:08.0: PM: completing bus resume driver flags: 0
[  407.610503] pcieport 0000:00:02.4: PM: completing bus resume driver flags: 5
[  407.610504] pcieport 0000:00:02.2: PM: completing bus resume driver flags: 5
[  407.610506] pci 0000:00:02.0: PM: completing bus resume driver flags: 0
[  407.610507] pci 0000:00:01.0: PM: completing bus resume driver flags: 0
[  407.610508] pci 0000:00:00.2: PM: completing bus resume driver flags: 0
[  407.610509] pci 0000:00:00.0: PM: completing bus resume driver flags: 0
[  407.611285] nvme nvme0: 8/0/0 default/read/poll queues
[  407.611745] OOM killer enabled.
[  407.611748] Restarting tasks: Starting
[  407.616441] Restarting tasks: Done
[  407.616701] random: crng reseeded on system resumption
[  407.631935] PM: suspend exit
[  407.867732] wlp1s0: authenticate with d6:92:5e:eb:ee:15 (local address=c8:15:4e:63:1d:e8)
[  407.869234] wlp1s0: send auth to d6:92:5e:eb:ee:15 (try 1/3)
[  407.915911] wlp1s0: authenticated
[  407.920208] wlp1s0: associate with d6:92:5e:eb:ee:15 (try 1/3)
[  407.930309] wlp1s0: RX AssocResp from d6:92:5e:eb:ee:15 (capab=0x1011 status=0 aid=13)
[  407.944229] wlp1s0: associated
[  408.033862] wlp1s0: Limiting TX power to 23 (23 - 0) dBm as advertised by d6:92:5e:eb:ee:15
[  412.170452] PM: suspend entry (s2idle)
[  412.443266] Filesystems sync: 0.272 seconds
[  412.443763] Freezing user space processes
[  412.445822] Freezing user space processes completed (elapsed 0.002 seconds)
[  412.445827] OOM killer disabled.
[  412.445828] Freezing remaining freezable tasks
[  412.447090] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  412.447094] printk: Suspending console(s) (use no_console_suspend to debug)
[  412.711856] snd_hda_codec_hdmi hdaudioC0D0: PM: direct-complete suspend driver flags: 0
[  412.711877] dummy 3-0037: PM: direct-complete suspend driver flags: 0
[  412.711899] dummy 3-0036: PM: direct-complete suspend driver flags: 0
[  412.711922] scsi_device 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  412.711944] scsi_host host0: PM: direct-complete suspend driver flags: 0
[  412.711955]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.711979]  ep_82: PM: direct-complete suspend driver flags: 0
[  412.712002]  ep_01: PM: direct-complete suspend driver flags: 0
[  412.712013] i2c i2c-8: PM: direct-complete suspend driver flags: 0
[  412.712026] i2c i2c-7: PM: direct-complete suspend driver flags: 0
[  412.712037] i2c i2c-6: PM: direct-complete suspend driver flags: 0
[  412.712050] i2c i2c-5: PM: direct-complete suspend driver flags: 0
[  412.712062] i2c i2c-4: PM: direct-complete suspend driver flags: 0
[  412.712075]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.712091]  ep_04: PM: direct-complete suspend driver flags: 0
[  412.712314] net lo: PM: direct-complete suspend driver flags: 0
[  412.712320]  ep_84: PM: direct-complete suspend driver flags: 0
[  412.712323]  ep_03: PM: direct-complete suspend driver flags: 0
[  412.712324]  ep_83: PM: direct-complete suspend driver flags: 0
[  412.712327]  ep_02: PM: direct-complete suspend driver flags: 0
[  412.712331]  ep_82: PM: direct-complete suspend driver flags: 0
[  412.712333]  ep_01: PM: direct-complete suspend driver flags: 0
[  412.712338]  ep_81: PM: direct-complete suspend driver flags: 0
[  412.712339]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.712340]  ep_83: PM: direct-complete suspend driver flags: 0
[  412.712340]  ep_03: PM: direct-complete suspend driver flags: 0
[  412.712342]  ep_82: PM: direct-complete suspend driver flags: 0
[  412.712343]  ep_02: PM: direct-complete suspend driver flags: 0
[  412.712344]  ep_81: PM: direct-complete suspend driver flags: 0
[  412.712347]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.712350]  ep_87: PM: direct-complete suspend driver flags: 0
[  412.712350]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.712351] uvcvideo 1-3:1.1: PM: direct-complete suspend driver flags: 0
[  412.712351]  ep_81: PM: direct-complete suspend driver flags: 0
[  412.712352]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.712352]  ep_81: PM: direct-complete suspend driver flags: 0
[  412.712359]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.712359] bdi 0:64: PM: direct-complete suspend driver flags: 0
[  412.712360]  ep_81: PM: direct-complete suspend driver flags: 0
[  412.712366]  ep_00: PM: direct-complete suspend driver flags: 0
[  412.712366]  ep_81: PM: direct-complete suspend driver flags: 0
[  412.712373] i2c i2c-2: PM: direct-complete suspend driver flags: 0
[  412.712375] i2c i2c-1: PM: direct-complete suspend driver flags: 0
[  412.712376] pcie_pme 0000:00:08.1:pcie001: PM: direct-complete suspend driver flags: 0
[  412.712376] pcie_bwctrl 0000:00:08.1:pcie010: PM: direct-complete suspend driver flags: 0
[  412.712377] pcie_bwctrl 0000:00:02.4:pcie010: PM: direct-complete suspend driver flags: 0
[  412.712377] pcie_pme 0000:00:02.4:pcie001: PM: direct-complete suspend driver flags: 0
[  412.712379] pcie_bwctrl 0000:00:02.2:pcie010: PM: direct-complete suspend driver flags: 0
[  412.712381] pcie_pme 0000:00:02.2:pcie001: PM: direct-complete suspend driver flags: 0
[  412.712382] pcie_mp2_amd 0000:03:00.7: PM: bus suspend driver flags: 0
[  412.712383] ccp 0000:03:00.2: PM: bus suspend driver flags: 0
[  412.712384] pci 0000:00:18.7: PM: bus suspend driver flags: 0
[  412.712384] pci 0000:00:18.6: PM: bus suspend driver flags: 0
[  412.712384] sound seq: PM: direct-complete suspend driver flags: 0
[  412.712384] pci 0000:00:18.5: PM: bus suspend driver flags: 0
[  412.712385] pci 0000:00:18.4: PM: bus suspend driver flags: 0
[  412.712385] pci 0000:00:18.2: PM: bus suspend driver flags: 0
[  412.712387] pci 0000:00:18.1: PM: bus suspend driver flags: 0
[  412.712388] pci 0000:00:18.0: PM: bus suspend driver flags: 0
[  412.712389] pci 0000:00:08.0: PM: bus suspend driver flags: 0
[  412.712390] pci 0000:00:02.0: PM: bus suspend driver flags: 0
[  412.712394] pci 0000:00:01.0: PM: bus suspend driver flags: 0
[  412.712395] pci 0000:00:00.0: PM: bus suspend driver flags: 0
[  412.712402] net br-bd31abe76a1b: PM: direct-complete suspend driver flags: 0
[  412.712405] btusb 3-3:1.1: PM: direct-complete suspend driver flags: 0
[  412.712406] net lo: PM: direct-complete suspend driver flags: 0
[  412.712407] usb 1-4:1.0: PM: direct-complete suspend driver flags: 0
[  412.712409] net docker0: PM: direct-complete suspend driver flags: 0
[  412.712413] ptp ptp0: PM: direct-complete suspend driver flags: 0
[  412.712417] usb 1-4: PM: type suspend driver flags: 0
[  412.712418]  port0.0: PM: direct-complete suspend driver flags: 0
[  412.712422]  4:variable_supply: PM: direct-complete suspend driver flags: 0
[  412.712426]  3:fixed_supply: PM: direct-complete suspend driver flags: 0
[  412.712429]  2:fixed_supply: PM: direct-complete suspend driver flags: 0
[  412.712432]  1:fixed_supply: PM: direct-complete suspend driver flags: 0
[  412.712432] usb usb2: PM: type suspend driver flags: 0
[  412.712436]  sink-capabilities: PM: direct-complete suspend driver flags: 0
[  412.712439]  1:fixed_supply: PM: direct-complete suspend driver flags: 0
[  412.712443]  source-capabilities: PM: direct-complete suspend driver flags: 0
[  412.712447] vc vcsa6: PM: direct-complete suspend driver flags: 0
[  412.712451] vc vcsu6: PM: direct-complete suspend driver flags: 0
[  412.712455] vc vcs6: PM: direct-complete suspend driver flags: 0
[  412.712457] vc vcsa5: PM: direct-complete suspend driver flags: 0
[  412.712459] vc vcsu5: PM: direct-complete suspend driver flags: 0
[  412.712461] vc vcs5: PM: direct-complete suspend driver flags: 0
[  412.712464] vc vcsa4: PM: direct-complete suspend driver flags: 0
[  412.712467] vc vcsu4: PM: direct-complete suspend driver flags: 0
[  412.712470] vc vcs4: PM: direct-complete suspend driver flags: 0
[  412.712472] vc vcsa3: PM: direct-complete suspend driver flags: 0
[  412.712475] vc vcsu3: PM: direct-complete suspend driver flags: 0
[  412.712477] vc vcs3: PM: direct-complete suspend driver flags: 0
[  412.712480] vc vcsa2: PM: direct-complete suspend driver flags: 0
[  412.712482] vc vcsu2: PM: direct-complete suspend driver flags: 0
[  412.712485] vc vcs2: PM: direct-complete suspend driver flags: 0
[  412.712487] net lo: PM: direct-complete suspend driver flags: 0
[  412.712489] net lo: PM: direct-complete suspend driver flags: 0
[  412.712492] net wlp1s0: PM: direct-complete suspend driver flags: 0
[  412.712497] rfkill rfkill1: PM: class suspend driver flags: 0
[  412.712509] leds phy0-led: PM: class suspend driver flags: 0
[  412.712515]  card2: PM: direct-complete suspend driver flags: 0
[  412.712518]  card2: PM: direct-complete suspend driver flags: 0
[  412.712519] ieee80211 phy0: PM: class suspend driver flags: 0
[  412.712520] sound controlC2: PM: direct-complete suspend driver flags: 0
[  412.712522] sound pcmC2D0c: PM: type suspend driver flags: 0
[  412.712525] wlp1s0: deauthenticating from d6:92:5e:eb:ee:15 by local choice (Reason: 3=DEAUTH_LEAVING)
[  412.712526]  acp3x-dmic-capture: PM: direct-complete suspend driver flags: 0
[  412.712530] acp_pdm_mach acp_pdm_mach.0: PM: bus suspend driver flags: 0
[  412.712550]  card1: PM: direct-complete suspend driver flags: 0
[  412.712551]  card1: PM: direct-complete suspend driver flags: 0
[  412.712553] sound controlC1: PM: direct-complete suspend driver flags: 0
[  412.712556] input event10: PM: direct-complete suspend driver flags: 0
[  412.712558] input input14: PM: type suspend driver flags: 0
[  412.712561] input event9: PM: direct-complete suspend driver flags: 0
[  412.712563] input input13: PM: type suspend driver flags: 0
[  412.712565] sound hwC1D0: PM: direct-complete suspend driver flags: 0
[  412.712567] sound pcmC1D0c: PM: type suspend driver flags: 0
[  412.712570] sound pcmC1D0p: PM: type suspend driver flags: 0
[  412.712576]  card0: PM: direct-complete suspend driver flags: 0
[  412.712577]  card0: PM: direct-complete suspend driver flags: 0
[  412.712580]  mic: PM: direct-complete suspend driver flags: 0
[  412.712583]  speaker: PM: direct-complete suspend driver flags: 0
[  412.712585] sound ctl-led: PM: direct-complete suspend driver flags: 0
[  412.712588] faux_driver snd-soc-dummy: PM: direct-complete suspend driver flags: 0
[  412.712592] leds hda::mute: PM: class suspend driver flags: 0
[  412.712655] media media0: PM: direct-complete suspend driver flags: 0
[  412.712660] video4linux video1: PM: direct-complete suspend driver flags: 0
[  412.712662] video4linux video0: PM: direct-complete suspend driver flags: 0
[  412.712665] sound controlC0: PM: direct-complete suspend driver flags: 0
[  412.712667] input event8: PM: direct-complete suspend driver flags: 0
[  412.712669] input input12: PM: type suspend driver flags: 0
[  412.712672] sound hwC0D0: PM: direct-complete suspend driver flags: 0
[  412.712672] uvcvideo 1-3:1.0: PM: direct-complete suspend driver flags: 0
[  412.712674] sound pcmC0D3p: PM: type suspend driver flags: 0
[  412.712696] usb 1-3: PM: type suspend driver flags: 0
[  412.712709] usb usb1: PM: type suspend driver flags: 0
[  412.712734] snd_hda_codec_realtek hdaudioC1D0: PM: driver suspend driver flags: 0
[  412.712739] powercap intel-rapl:0:0: PM: direct-complete suspend driver flags: 0
[  412.712742] powercap intel-rapl:0: PM: direct-complete suspend driver flags: 0
[  412.712745] powercap intel-rapl: PM: direct-complete suspend driver flags: 0
[  412.712747] hwmon hwmon8: PM: direct-complete suspend driver flags: 0
[  412.712749] thermal thermal_zone2: PM: direct-complete suspend driver flags: 0
[  412.712751] intel_rapl_msr intel_rapl_msr.0: PM: bus suspend driver flags: 0
[  412.712754] misc kvm: PM: direct-complete suspend driver flags: 0
[  412.712757] usb_power_delivery pd0: PM: direct-complete suspend driver flags: 0
[  412.712757] snd_hda_intel 0000:03:00.1: PM: bus suspend driver flags: 0
[  412.712759] typec port0: PM: direct-complete suspend driver flags: 0
[  412.712761] hwmon hwmon7: PM: direct-complete suspend driver flags: 0
[  412.712765] rfkill rfkill0: PM: class suspend driver flags: 0
[  412.712771] platform-profile platform-profile-0: PM: direct-complete suspend driver flags: 0
[  412.712773] hwmon hwmon6: PM: direct-complete suspend driver flags: 0
[  412.712776] hp-wmi hp-wmi: PM: bus suspend driver flags: 0
[  412.712778] input event7: PM: direct-complete suspend driver flags: 0
[  412.712781] input input11: PM: type suspend driver flags: 0
[  412.712783] dmic-codec dmic-codec.0: PM: bus suspend driver flags: 0
[  412.712786] acp_rn_pdm_dma acp_rn_pdm_dma.0: PM: bus suspend driver flags: 0
[  412.712789] nvmem 3-0051: PM: direct-complete suspend driver flags: 0
[  412.712793] nvmem 3-0050: PM: direct-complete suspend driver flags: 0
[  412.712796] sound timer: PM: direct-complete suspend driver flags: 0
[  412.712798] scsi_generic sg0: PM: direct-complete suspend driver flags: 0
[  412.712800] platform regulatory.0: PM: bus suspend driver flags: 0
[  412.712799] usb 3-3: PM: type suspend driver flags: 0
[  412.712803] event_source power_core: PM: direct-complete suspend driver flags: 0
[  412.712803] ee1004 3-0051: PM: direct-complete suspend driver flags: 0
[  412.712805] event_source power: PM: direct-complete suspend driver flags: 0
[  412.712807] watchdog watchdog0: PM: direct-complete suspend driver flags: 0
[  412.712808] ee1004 3-0050: PM: direct-complete suspend driver flags: 0
[  412.712809] snd_rn_pci_acp3x 0000:03:00.5: PM: bus suspend driver flags: 0
[  412.712810] misc watchdog: PM: direct-complete suspend driver flags: 0
[  412.712813] sp5100-tco sp5100-tco: PM: bus suspend driver flags: 0
[  412.712815] input event6: PM: direct-complete suspend driver flags: 0
[  412.712817] input input10: PM: type suspend driver flags: 0
[  412.712820] hwmon hwmon5: PM: direct-complete suspend driver flags: 0
[  412.712823] hwmon hwmon4: PM: direct-complete suspend driver flags: 0
[  412.712827] hwmon hwmon3: PM: direct-complete suspend driver flags: 0
[  412.712829] power_supply BAT0: PM: direct-complete suspend driver flags: 0
[  412.712830] i2c i2c-3: PM: direct-complete suspend driver flags: 0
[  412.712831] misc rfkill: PM: direct-complete suspend driver flags: 0
[  412.712833] input event5: PM: direct-complete suspend driver flags: 0
[  412.712832] k10temp 0000:00:18.3: PM: bus suspend driver flags: 0
[  412.712835] input event4: PM: direct-complete suspend driver flags: 0
[  412.712837] input event3: PM: direct-complete suspend driver flags: 0
[  412.712839] input event2: PM: direct-complete suspend driver flags: 0
[  412.712841] input event1: PM: direct-complete suspend driver flags: 0
[  412.712841] piix4_smbus 0000:00:14.0: PM: bus suspend driver flags: 0
[  412.712843] input event0: PM: direct-complete suspend driver flags: 0
[  412.712845] msr msr15: PM: direct-complete suspend driver flags: 0
[  412.712847] msr msr14: PM: direct-complete suspend driver flags: 0
[  412.712849] msr msr13: PM: direct-complete suspend driver flags: 0
[  412.712851] msr msr12: PM: direct-complete suspend driver flags: 0
[  412.712853] msr msr11: PM: direct-complete suspend driver flags: 0
[  412.712855] msr msr10: PM: direct-complete suspend driver flags: 0
[  412.712857] msr msr9: PM: direct-complete suspend driver flags: 0
[  412.712859] msr msr8: PM: direct-complete suspend driver flags: 0
[  412.712861] msr msr7: PM: direct-complete suspend driver flags: 0
[  412.712863] msr msr6: PM: direct-complete suspend driver flags: 0
[  412.712865] msr msr5: PM: direct-complete suspend driver flags: 0
[  412.712868] msr msr4: PM: direct-complete suspend driver flags: 0
[  412.712870] msr msr3: PM: direct-complete suspend driver flags: 0
[  412.712872] msr msr2: PM: direct-complete suspend driver flags: 0
[  412.712878] msr msr1: PM: direct-complete suspend driver flags: 0
[  412.712880] msr msr0: PM: direct-complete suspend driver flags: 0
[  412.712881] misc device-mapper: PM: direct-complete suspend driver flags: 0
[  412.712883] misc nvme-fabrics: PM: direct-complete suspend driver flags: 0
[  412.712886] nvme-fabrics ctl: PM: direct-complete suspend driver flags: 0
[  412.712888] misc autofs: PM: direct-complete suspend driver flags: 0
[  412.712891] bdi btrfs-1: PM: direct-complete suspend driver flags: 0
[  412.712893] block sda2: PM: direct-complete suspend driver flags: 0
[  412.712895] block sda1: PM: direct-complete suspend driver flags: 0
[  412.712897] bdi 8:0: PM: direct-complete suspend driver flags: 0
[  412.712899] block sda: PM: direct-complete suspend driver flags: 0
[  412.712902] scsi_disk 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  412.712904] bsg 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  412.712908] misc btrfs-control: PM: direct-complete suspend driver flags: 0
[  412.712911] workqueue scsi_tmf_0: PM: direct-complete suspend driver flags: 0
[  412.712912] sd 0:0:0:0: PM: bus suspend driver flags: 0
[  412.712913] vtconsole vtcon1: PM: direct-complete suspend driver flags: 0
[  412.712915] graphics fb0: PM: direct-complete suspend driver flags: 0
[  412.712918] drm_dp_aux_dev drm_dp_aux1: PM: direct-complete suspend driver flags: 0
[  412.712921] drm card0-DP-1: PM: direct-complete suspend driver flags: 0
[  412.712923] drm card0-HDMI-A-1: PM: direct-complete suspend driver flags: 0
[  412.712925] drm_dp_aux_dev drm_dp_aux0: PM: direct-complete suspend driver flags: 0
[  412.712927] backlight amdgpu_bl0: PM: class suspend driver flags: 0
[  412.712935] drm renderD128: PM: direct-complete suspend driver flags: 0
[  412.712937] hwmon hwmon2: PM: direct-complete suspend driver flags: 0
[  412.712940] kfd kfd: PM: direct-complete suspend driver flags: 0
[  412.712946] hidraw hidraw0: PM: direct-complete suspend driver flags: 0
[  412.712950] input mouse1: PM: direct-complete suspend driver flags: 0
[  412.712952] input input9: PM: type suspend driver flags: 0
[  412.712955] input mouse0: PM: direct-complete suspend driver flags: 0
[  412.712957] input input7: PM: type suspend driver flags: 0
[  412.712962] nvme-generic ng0n1: PM: direct-complete suspend driver flags: 0
[  412.712965] block nvme0n1p4: PM: direct-complete suspend driver flags: 0
[  412.712967] block nvme0n1p3: PM: direct-complete suspend driver flags: 0
[  412.712969] i2c_hid_acpi i2c-ELAN074E:00: PM: power domain suspend, may wakeup driver flags: 0
[  412.712969] block nvme0n1p2: PM: direct-complete suspend driver flags: 0
[  412.712971] block nvme0n1p1: PM: direct-complete suspend driver flags: 0
[  412.712974] bdi 259:0: PM: direct-complete suspend driver flags: 0
[  412.712977] block nvme0n1: PM: direct-complete suspend driver flags: 0
[  412.712980] hwmon hwmon1: PM: direct-complete suspend driver flags: 0
[  412.712982] nvme-subsystem nvme-subsys0: PM: direct-complete suspend driver flags: 0
[  412.712984] nvme nvme0: PM: direct-complete suspend driver flags: 0
[  412.712987] workqueue nvme-auth-wq: PM: direct-complete suspend driver flags: 0
[  412.712989] workqueue nvme-delete-wq: PM: direct-complete suspend driver flags: 0
[  412.712991] workqueue nvme-reset-wq: PM: direct-complete suspend driver flags: 0
[  412.712993] workqueue nvme-wq: PM: direct-complete suspend driver flags: 0
[  412.712995] input input3: PM: type suspend driver flags: 0
[  412.712998] thermal cooling_device16: PM: direct-complete suspend driver flags: 0
[  412.713000] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-4: PM: direct-complete suspend driver flags: 0
[  412.713003] wmi ABBC0F6A-8EA1-11D1-00A0-C90629100000: PM: direct-complete suspend driver flags: 0
[  412.713005] input input2: PM: type suspend driver flags: 0
[  412.713008] wmi_bus wmi_bus-PNP0C14:04: PM: direct-complete suspend driver flags: 0
[  412.713010] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-3: PM: direct-complete suspend driver flags: 0
[  412.713012] wmi 40D1BF71-A82D-4E59-A168-3985E03B2E87: PM: direct-complete suspend driver flags: 0
[  412.713014] wmi 431F16ED-0C2B-444C-B267-27DEB140CF9C: PM: direct-complete suspend driver flags: 0
[  412.713016] wmi 67C3371D-95A3-4C37-BB61-DD47B491DAAB: PM: direct-complete suspend driver flags: 0
[  412.713018] wmi D9F41781-F633-4400-9355-601770BEC510: PM: direct-complete suspend driver flags: 0
[  412.713021] wmi_bus wmi_bus-PNP0C14:03: PM: direct-complete suspend driver flags: 0
[  412.713023] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-2: PM: direct-complete suspend driver flags: 0
[  412.713025] wmi 1F13AB7F-6220-4210-8F8E-8BB5E71EE969: PM: direct-complete suspend driver flags: 0
[  412.713027] input input1: PM: type suspend driver flags: 0
[  412.713029] wmi_bus wmi_bus-PNP0C14:02: PM: direct-complete suspend driver flags: 0
[  412.713031] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-1: PM: direct-complete suspend driver flags: 0
[  412.713033] wmi A6FEA33E-DABF-46F5-BFC8-460D961BEC9F: PM: direct-complete suspend driver flags: 0
[  412.713035] wmi 2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B: PM: direct-complete suspend driver flags: 0
[  412.713038] wmi_bus wmi_bus-PNP0C14:01: PM: direct-complete suspend driver flags: 0
[  412.713040] wmi 8232DE3D-663D-4327-A8F4-E293ADB9BF05: PM: direct-complete suspend driver flags: 0
[  412.713042] wmi 322F2028-0F84-4901-988E-015176049E2D: PM: direct-complete suspend driver flags: 0
[  412.713044] wmi 14EA9746-CE1F-4098-A0E0-7045CB4DA745: PM: direct-complete suspend driver flags: 0
[  412.713046] wmi 988D08E3-68F4-4C35-AF3E-6A1B8106F83C: PM: direct-complete suspend driver flags: 0
[  412.713047] wmi 2D114B49-2DFB-4130-B8FE-4A3C09E75133: PM: direct-complete suspend driver flags: 0
[  412.713049] wmi 1F4C91EB-DC5C-460B-951D-C7CB9B4B8D5E: PM: direct-complete suspend driver flags: 0
[  412.713051] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910: PM: direct-complete suspend driver flags: 0
[  412.713053] wmi 2B814318-4BE8-4707-9D84-A190A859B5D0: PM: direct-complete suspend driver flags: 0
[  412.713055] wmi 95F24279-4D7B-4334-9387-ACCDC67EF61C: PM: direct-complete suspend driver flags: 0
[  412.713057] wmi 5FB7F034-2C63-45E9-BE91-3D44E2C707E4: PM: direct-complete suspend driver flags: 0
[  412.713061] wmi_bus wmi_bus-PNP0C14:00: PM: direct-complete suspend driver flags: 0
[  412.713063] memory_tiering memory_tier4: PM: direct-complete suspend driver flags: 0
[  412.713065] misc cpu_dma_latency: PM: direct-complete suspend driver flags: 0
[  412.713067] platform microcode: PM: bus suspend driver flags: 0
[  412.713070] machinecheck machinecheck15: PM: direct-complete suspend driver flags: 0
[  412.713071] machinecheck machinecheck14: PM: direct-complete suspend driver flags: 0
[  412.713073] machinecheck machinecheck13: PM: direct-complete suspend driver flags: 0
[  412.713075] machinecheck machinecheck12: PM: direct-complete suspend driver flags: 0
[  412.713077] machinecheck machinecheck11: PM: direct-complete suspend driver flags: 0
[  412.713079] machinecheck machinecheck10: PM: direct-complete suspend driver flags: 0
[  412.713081] machinecheck machinecheck9: PM: direct-complete suspend driver flags: 0
[  412.713083] machinecheck machinecheck8: PM: direct-complete suspend driver flags: 0
[  412.713085] machinecheck machinecheck7: PM: direct-complete suspend driver flags: 0
[  412.713086] machinecheck machinecheck6: PM: direct-complete suspend driver flags: 0
[  412.713088] machinecheck machinecheck5: PM: direct-complete suspend driver flags: 0
[  412.713090] machinecheck machinecheck4: PM: direct-complete suspend driver flags: 0
[  412.713092] machinecheck machinecheck3: PM: direct-complete suspend driver flags: 0
[  412.713094] machinecheck machinecheck2: PM: direct-complete suspend driver flags: 0
[  412.713095] machinecheck machinecheck1: PM: direct-complete suspend driver flags: 0
[  412.713097] machinecheck machinecheck0: PM: direct-complete suspend driver flags: 0
[  412.713099]  machinecheck: PM: direct-complete suspend driver flags: 0
[  412.713101] leds input0::scrolllock: PM: class suspend driver flags: 0
[  412.713103] leds input0::capslock: PM: class suspend driver flags: 0
[  412.713106] leds input0::numlock: PM: class suspend driver flags: 0
[  412.713109] input input0: PM: type suspend driver flags: 0
[  412.713111] nvmem cmos_nvram0: PM: direct-complete suspend driver flags: 0
[  412.713114] alarmtimer alarmtimer.0.auto: PM: bus suspend, may wakeup driver flags: 0
[  412.713118] rtc rtc0: PM: class suspend driver flags: 0
[  412.713120] misc psaux: PM: direct-complete suspend driver flags: 0
[  412.713123] atkbd serio0: PM: bus suspend, may wakeup driver flags: 0
[  412.713898] nvme 0000:02:00.0: PM: bus suspend driver flags: 0
[  412.715244] i2c_designware AMDI0010:03: PM: power domain suspend driver flags: 6
[  412.717232] input mice: PM: direct-complete suspend driver flags: 0
[  412.717235] i8042 i8042: PM: bus suspend driver flags: 0
[  412.717241] misc udmabuf: PM: direct-complete suspend driver flags: 0
[  412.717243] dma_heap system: PM: direct-complete suspend driver flags: 0
[  412.717246] tpmrm tpmrm0: PM: direct-complete suspend driver flags: 0
[  412.717249] tpm tpm0: PM: direct-complete suspend driver flags: 0
[  412.717251] misc hpet: PM: direct-complete suspend driver flags: 0
[  412.717254] tty ttyS3: PM: direct-complete suspend driver flags: 0
[  412.717257] port serial8250:0.3: PM: driver suspend driver flags: 0
[  412.717260] tty ttyS2: PM: direct-complete suspend driver flags: 0
[  412.717262] port serial8250:0.2: PM: driver suspend driver flags: 0
[  412.717265] tty ttyS1: PM: direct-complete suspend driver flags: 0
[  412.717268] port serial8250:0.1: PM: driver suspend driver flags: 0
[  412.717271] tty ttyS0: PM: direct-complete suspend driver flags: 0
[  412.717274] port serial8250:0.0: PM: driver suspend driver flags: 0
[  412.717279] serial8250 serial8250: PM: bus suspend driver flags: 0
[  412.717283] tty ptmx: PM: direct-complete suspend driver flags: 0
[  412.717285] thermal thermal_zone1: PM: direct-complete suspend driver flags: 0
[  412.717288] hwmon hwmon0: PM: direct-complete suspend driver flags: 0
[  412.717290] thermal thermal_zone0: PM: direct-complete suspend driver flags: 0
[  412.717293] thermal cooling_device15: PM: direct-complete suspend driver flags: 0
[  412.717295] thermal cooling_device14: PM: direct-complete suspend driver flags: 0
[  412.717297] thermal cooling_device13: PM: direct-complete suspend driver flags: 0
[  412.717300] thermal cooling_device12: PM: direct-complete suspend driver flags: 0
[  412.717302] thermal cooling_device11: PM: direct-complete suspend driver flags: 0
[  412.717304] thermal cooling_device10: PM: direct-complete suspend driver flags: 0
[  412.717306] thermal cooling_device9: PM: direct-complete suspend driver flags: 0
[  412.717309] thermal cooling_device8: PM: direct-complete suspend driver flags: 0
[  412.717311] thermal cooling_device7: PM: direct-complete suspend driver flags: 0
[  412.717313] thermal cooling_device6: PM: direct-complete suspend driver flags: 0
[  412.717315] thermal cooling_device5: PM: direct-complete suspend driver flags: 0
[  412.717318] thermal cooling_device4: PM: direct-complete suspend driver flags: 0
[  412.717320] thermal cooling_device3: PM: direct-complete suspend driver flags: 0
[  412.717322] thermal cooling_device2: PM: direct-complete suspend driver flags: 0
[  412.717324] thermal cooling_device1: PM: direct-complete suspend driver flags: 0
[  412.717326] thermal cooling_device0: PM: direct-complete suspend driver flags: 0
[  412.717330] gpio gpiochip512: PM: direct-complete suspend driver flags: 0
[  412.717332] gpio gpiochip0: PM: direct-complete suspend driver flags: 0
[  412.717335] misc fuse: PM: direct-complete suspend driver flags: 0
[  412.717337] misc userfaultfd: PM: direct-complete suspend driver flags: 0
[  412.717340] event_source software: PM: direct-complete suspend driver flags: 0
[  412.717342] event_source tracepoint: PM: direct-complete suspend driver flags: 0
[  412.717345] event_source kprobe: PM: direct-complete suspend driver flags: 0
[  412.717347] event_source uprobe: PM: direct-complete suspend driver flags: 0
[  412.717349] event_source breakpoint: PM: direct-complete suspend driver flags: 0
[  412.717352] event_source cpu: PM: direct-complete suspend driver flags: 0
[  412.717354] event_source ibs_fetch: PM: direct-complete suspend driver flags: 0
[  412.717356] event_source ibs_op: PM: direct-complete suspend driver flags: 0
[  412.717359] event_source amd_df: PM: direct-complete suspend driver flags: 0
[  412.717361] event_source amd_l3: PM: direct-complete suspend driver flags: 0
[  412.717363] event_source amd_iommu_0: PM: direct-complete suspend driver flags: 0
[  412.717365] event_source msr: PM: direct-complete suspend driver flags: 0
[  412.717368] clockevents broadcast: PM: direct-complete suspend driver flags: 0
[  412.717370] clockevents clockevent15: PM: direct-complete suspend driver flags: 0
[  412.717373] clockevents clockevent14: PM: direct-complete suspend driver flags: 0
[  412.717375] clockevents clockevent13: PM: direct-complete suspend driver flags: 0
[  412.717377] clockevents clockevent12: PM: direct-complete suspend driver flags: 0
[  412.717379] clockevents clockevent11: PM: direct-complete suspend driver flags: 0
[  412.717382] clockevents clockevent10: PM: direct-complete suspend driver flags: 0
[  412.717384] clockevents clockevent9: PM: direct-complete suspend driver flags: 0
[  412.717386] clockevents clockevent8: PM: direct-complete suspend driver flags: 0
[  412.717388] clockevents clockevent7: PM: direct-complete suspend driver flags: 0
[  412.717391] clockevents clockevent6: PM: direct-complete suspend driver flags: 0
[  412.717393] clockevents clockevent5: PM: direct-complete suspend driver flags: 0
[  412.717395] clockevents clockevent4: PM: direct-complete suspend driver flags: 0
[  412.717397] clockevents clockevent3: PM: direct-complete suspend driver flags: 0
[  412.717399] clockevents clockevent2: PM: direct-complete suspend driver flags: 0
[  412.717402] clockevents clockevent1: PM: direct-complete suspend driver flags: 0
[  412.717404] clockevents clockevent0: PM: direct-complete suspend driver flags: 0
[  412.717406]  clockevents: PM: direct-complete suspend driver flags: 0
[  412.717408] clocksource clocksource0: PM: direct-complete suspend driver flags: 0
[  412.717411]  clocksource: PM: direct-complete suspend driver flags: 0
[  412.717413] misc snapshot: PM: direct-complete suspend driver flags: 0
[  412.717415] pcspkr pcspkr: PM: bus suspend driver flags: 0
[  412.717427] iommu ivhd0: PM: direct-complete suspend driver flags: 0
[  412.717433] misc hw_random: PM: direct-complete suspend driver flags: 0
[  412.717435] tty tty63: PM: direct-complete suspend driver flags: 0
[  412.717437] pci 0000:00:00.2: PM: bus suspend driver flags: 0
[  412.717437] tty tty62: PM: direct-complete suspend driver flags: 0
[  412.717440] tty tty61: PM: direct-complete suspend driver flags: 0
[  412.717442] tty tty60: PM: direct-complete suspend driver flags: 0
[  412.717444] tty tty59: PM: direct-complete suspend driver flags: 0
[  412.717446] tty tty58: PM: direct-complete suspend driver flags: 0
[  412.717449] tty tty57: PM: direct-complete suspend driver flags: 0
[  412.717451] tty tty56: PM: direct-complete suspend driver flags: 0
[  412.717454] tty tty55: PM: direct-complete suspend driver flags: 0
[  412.717456] tty tty54: PM: direct-complete suspend driver flags: 0
[  412.717458] tty tty53: PM: direct-complete suspend driver flags: 0
[  412.717460] tty tty52: PM: direct-complete suspend driver flags: 0
[  412.717462] tty tty51: PM: direct-complete suspend driver flags: 0
[  412.717465] tty tty50: PM: direct-complete suspend driver flags: 0
[  412.717467] tty tty49: PM: direct-complete suspend driver flags: 0
[  412.717469] tty tty48: PM: direct-complete suspend driver flags: 0
[  412.717471] tty tty47: PM: direct-complete suspend driver flags: 0
[  412.717474] tty tty46: PM: direct-complete suspend driver flags: 0
[  412.717476] tty tty45: PM: direct-complete suspend driver flags: 0
[  412.717478] tty tty44: PM: direct-complete suspend driver flags: 0
[  412.717480] tty tty43: PM: direct-complete suspend driver flags: 0
[  412.717483] tty tty42: PM: direct-complete suspend driver flags: 0
[  412.717485] tty tty41: PM: direct-complete suspend driver flags: 0
[  412.717487] tty tty40: PM: direct-complete suspend driver flags: 0
[  412.717489] tty tty39: PM: direct-complete suspend driver flags: 0
[  412.717491] tty tty38: PM: direct-complete suspend driver flags: 0
[  412.717494] tty tty37: PM: direct-complete suspend driver flags: 0
[  412.717496] tty tty36: PM: direct-complete suspend driver flags: 0
[  412.717498] tty tty35: PM: direct-complete suspend driver flags: 0
[  412.717500] tty tty34: PM: direct-complete suspend driver flags: 0
[  412.717502] tty tty33: PM: direct-complete suspend driver flags: 0
[  412.717505] tty tty32: PM: direct-complete suspend driver flags: 0
[  412.717507] tty tty31: PM: direct-complete suspend driver flags: 0
[  412.717509] tty tty30: PM: direct-complete suspend driver flags: 0
[  412.717511] tty tty29: PM: direct-complete suspend driver flags: 0
[  412.717513] tty tty28: PM: direct-complete suspend driver flags: 0
[  412.717516] tty tty27: PM: direct-complete suspend driver flags: 0
[  412.717518] tty tty26: PM: direct-complete suspend driver flags: 0
[  412.717520] tty tty25: PM: direct-complete suspend driver flags: 0
[  412.717522] tty tty24: PM: direct-complete suspend driver flags: 0
[  412.717524] tty tty23: PM: direct-complete suspend driver flags: 0
[  412.717527] tty tty22: PM: direct-complete suspend driver flags: 0
[  412.717529] tty tty21: PM: direct-complete suspend driver flags: 0
[  412.717531] tty tty20: PM: direct-complete suspend driver flags: 0
[  412.717533] tty tty19: PM: direct-complete suspend driver flags: 0
[  412.717536] tty tty18: PM: direct-complete suspend driver flags: 0
[  412.717538] tty tty17: PM: direct-complete suspend driver flags: 0
[  412.717540] tty tty16: PM: direct-complete suspend driver flags: 0
[  412.717542] tty tty15: PM: direct-complete suspend driver flags: 0
[  412.717544] tty tty14: PM: direct-complete suspend driver flags: 0
[  412.717546] tty tty13: PM: direct-complete suspend driver flags: 0
[  412.717549] tty tty12: PM: direct-complete suspend driver flags: 0
[  412.717551] tty tty11: PM: direct-complete suspend driver flags: 0
[  412.717553] tty tty10: PM: direct-complete suspend driver flags: 0
[  412.717555] tty tty9: PM: direct-complete suspend driver flags: 0
[  412.717558] tty tty8: PM: direct-complete suspend driver flags: 0
[  412.717560] tty tty7: PM: direct-complete suspend driver flags: 0
[  412.717562] tty tty6: PM: direct-complete suspend driver flags: 0
[  412.717564] tty tty5: PM: direct-complete suspend driver flags: 0
[  412.717567] tty tty4: PM: direct-complete suspend driver flags: 0
[  412.717569] tty tty3: PM: direct-complete suspend driver flags: 0
[  412.717571] tty tty2: PM: direct-complete suspend driver flags: 0
[  412.717573] tty tty1: PM: direct-complete suspend driver flags: 0
[  412.717576] vc vcsa1: PM: direct-complete suspend driver flags: 0
[  412.717578] vc vcsu1: PM: direct-complete suspend driver flags: 0
[  412.717580] vc vcs1: PM: direct-complete suspend driver flags: 0
[  412.717582] vc vcsa: PM: direct-complete suspend driver flags: 0
[  412.717585] vc vcsu: PM: direct-complete suspend driver flags: 0
[  412.717587] vc vcs: PM: direct-complete suspend driver flags: 0
[  412.717589] tty tty0: PM: direct-complete suspend driver flags: 0
[  412.717591] tty console: PM: direct-complete suspend driver flags: 0
[  412.717593] tty tty: PM: direct-complete suspend driver flags: 0
[  412.717596] mem kmsg: PM: direct-complete suspend driver flags: 0
[  412.717599] mem urandom: PM: direct-complete suspend driver flags: 0
[  412.717602] mem random: PM: direct-complete suspend driver flags: 0
[  412.717606] mem full: PM: direct-complete suspend driver flags: 0
[  412.717609] mem zero: PM: direct-complete suspend driver flags: 0
[  412.717611] mem port: PM: direct-complete suspend driver flags: 0
[  412.717613] mem null: PM: direct-complete suspend driver flags: 0
[  412.717616] mem mem: PM: direct-complete suspend driver flags: 0
[  412.717618] system 00:03: PM: bus suspend driver flags: 0
[  412.717621] i8042 kbd 00:02: PM: bus suspend driver flags: 0
[  412.717625] rtc_cmos 00:01: PM: bus suspend, may wakeup driver flags: 0
[  412.717654] system 00:00: PM: bus suspend driver flags: 0
[  412.717659] misc vga_arbiter: PM: direct-complete suspend driver flags: 0
[  412.717661] net lo: PM: direct-complete suspend driver flags: 0
[  412.717663] platform efivars.0: PM: bus suspend driver flags: 0
[  412.717666] platform rtc-efi.0: PM: bus suspend driver flags: 0
[  412.717669] edac mc: PM: direct-complete suspend driver flags: 0
[  412.717671]  edac: PM: direct-complete suspend driver flags: 0
[  412.717674] acpi ELAN074E:00: PM: direct-complete suspend driver flags: 0
[  412.717677] acpi-wmi PNP0C14:04: PM: power domain suspend driver flags: 0
[  412.717681] platform PNP0103:00: PM: bus suspend driver flags: 0
[  412.717684] acpi-fan PNP0C0B:00: PM: bus suspend driver flags: 0
[  412.717687] amd_pmc AMDI0005:00: PM: power domain suspend driver flags: 0
[  412.717691] ucsi_acpi USBC000:00: PM: power domain suspend driver flags: 0
[  412.717694] platform ACPI000E:00: PM: bus suspend driver flags: 0
[  412.717697] acpi-wmi PNP0C14:03: PM: power domain suspend driver flags: 0
[  412.717700] platform PNP0C0D:00: PM: bus suspend driver flags: 0
[  412.717703] acpi-wmi PNP0C14:02: PM: power domain suspend driver flags: 0
[  412.717707] acpi-wmi PNP0C14:01: PM: power domain suspend driver flags: 0
[  412.717711] acpi-wmi PNP0C14:00: PM: power domain suspend driver flags: 0
[  412.717714] platform MSFT0101:00: PM: bus suspend driver flags: 0
[  412.717717] amd_gpio AMDI0030:00: PM: power domain suspend driver flags: 0
[  412.717720] platform acpi-cpufreq: PM: bus suspend driver flags: 0
[  412.717723] platform PNP0C0C:00: PM: bus suspend driver flags: 0
[  412.717726] platform HPIC0003:00: PM: bus suspend driver flags: 0
[  412.717729] platform PNP0C0A:00: PM: bus suspend driver flags: 0
[  412.717731] ac ACPI0003:00: PM: power domain suspend driver flags: 0
[  412.717735] platform PNP0C09:00: PM: bus suspend driver flags: 0
[  412.717740] platform PNP0800:00: PM: bus suspend driver flags: 0
[  412.717743] pci 0000:00:14.3: PM: bus suspend driver flags: 0
[  412.717745] pci_bus 0000:03: PM: direct-complete suspend driver flags: 0
[  412.717751] pci_bus 0000:02: PM: direct-complete suspend driver flags: 0
[  412.717754] pci_bus 0000:01: PM: direct-complete suspend driver flags: 0
[  412.717764] pci_bus 0000:00: PM: direct-complete suspend driver flags: 0
[  412.717770] acpi PNP0C14:04: PM: direct-complete suspend driver flags: 0
[  412.717775] acpi PNP0103:00: PM: direct-complete suspend driver flags: 0
[  412.717778] thermal LNXTHERM:01: PM: driver suspend driver flags: 0
[  412.717789] thermal LNXTHERM:00: PM: driver suspend driver flags: 0
[  412.717794] acpi PNP0C0B:00: PM: direct-complete suspend driver flags: 0
[  412.717797] acpi LNXPOWER:09: PM: direct-complete suspend driver flags: 0
[  412.717802] acpi AMDI0005:00: PM: direct-complete suspend driver flags: 0
[  412.717804] acpi device:3f: PM: direct-complete suspend driver flags: 0
[  412.717807] acpi USBC000:00: PM: direct-complete suspend driver flags: 0
[  412.717810] acpi ACPI000C:00: PM: direct-complete suspend driver flags: 0
[  412.717812] acpi ACPI000E:00: PM: direct-complete suspend driver flags: 0
[  412.717814] acpi PNP0C02:0d: PM: direct-complete suspend driver flags: 0
[  412.717816] acpi PNP0C02:0c: PM: direct-complete suspend driver flags: 0
[  412.717818] acpi PNP0C02:0b: PM: direct-complete suspend driver flags: 0
[  412.717820] acpi PNP0C02:0a: PM: direct-complete suspend driver flags: 0
[  412.717822] acpi PNP0C02:09: PM: direct-complete suspend driver flags: 0
[  412.717824] acpi PNP0C02:08: PM: direct-complete suspend driver flags: 0
[  412.717826] acpi PNP0C02:07: PM: direct-complete suspend driver flags: 0
[  412.717828] acpi PNP0C02:06: PM: direct-complete suspend driver flags: 0
[  412.717830] acpi PNP0C02:05: PM: direct-complete suspend driver flags: 0
[  412.717832] acpi PNP0C02:04: PM: direct-complete suspend driver flags: 0
[  412.717836] acpi PNP0C02:03: PM: direct-complete suspend driver flags: 0
[  412.717838] acpi LNXPOWER:08: PM: direct-complete suspend driver flags: 0
[  412.717840] acpi LNXPOWER:07: PM: direct-complete suspend driver flags: 0
[  412.717842] acpi HPQ6007:00: PM: direct-complete suspend driver flags: 0
[  412.717843] acpi HPQ6001:00: PM: direct-complete suspend driver flags: 0
[  412.717846] acpi PNP0C14:03: PM: direct-complete suspend driver flags: 0
[  412.717847] acpi PNP0C0E:00: PM: direct-complete suspend driver flags: 0
[  412.717850] button PNP0C0D:00: PM: driver suspend, may wakeup driver flags: 0
[  412.717853] acpi PNP0C14:02: PM: direct-complete suspend driver flags: 0
[  412.717855] acpi PNP0C14:01: PM: direct-complete suspend driver flags: 0
[  412.717858] acpi PNP0C14:00: PM: direct-complete suspend driver flags: 0
[  412.717860] tpm_crb MSFT0101:00: PM: driver suspend driver flags: 0
[  412.719069] acpi AMDI0040:00: PM: direct-complete suspend driver flags: 0
[  412.719072] acpi AMDI0010:05: PM: direct-complete suspend driver flags: 0
[  412.719074] acpi AMDI0010:04: PM: direct-complete suspend driver flags: 0
[  412.719077] acpi AMDI0010:03: PM: direct-complete suspend driver flags: 0
[  412.719079] acpi AMDI0010:02: PM: direct-complete suspend driver flags: 0
[  412.719081] acpi AMDI0010:01: PM: direct-complete suspend driver flags: 0
[  412.719083] acpi AMDI0010:00: PM: direct-complete suspend driver flags: 0
[  412.719085] acpi AMDI0020:03: PM: direct-complete suspend driver flags: 0
[  412.719087] acpi AMDI0020:02: PM: direct-complete suspend driver flags: 0
[  412.719089] acpi AMDI0020:01: PM: direct-complete suspend driver flags: 0
[  412.719091] acpi AMDI0020:00: PM: direct-complete suspend driver flags: 0
[  412.719093] acpi AMDI0030:00: PM: direct-complete suspend driver flags: 0
[  412.719095] acpi AMDI0060:00: PM: direct-complete suspend driver flags: 0
[  412.719097] acpi PNP0C0F:07: PM: direct-complete suspend driver flags: 0
[  412.719099] acpi PNP0C0F:06: PM: direct-complete suspend driver flags: 0
[  412.719101] acpi PNP0C0F:05: PM: direct-complete suspend driver flags: 0
[  412.719103] acpi PNP0C0F:04: PM: direct-complete suspend driver flags: 0
[  412.719106] acpi PNP0C0F:03: PM: direct-complete suspend driver flags: 0
[  412.719108] acpi PNP0C0F:02: PM: direct-complete suspend driver flags: 0
[  412.719110] acpi PNP0C0F:01: PM: direct-complete suspend driver flags: 0
[  412.719111] acpi PNP0C0F:00: PM: direct-complete suspend driver flags: 0
[  412.719114] acpi ACPI0007:0f: PM: direct-complete suspend driver flags: 0
[  412.719116] acpi ACPI0007:0e: PM: direct-complete suspend driver flags: 0
[  412.719118] acpi ACPI0007:0d: PM: direct-complete suspend driver flags: 0
[  412.719120] acpi ACPI0007:0c: PM: direct-complete suspend driver flags: 0
[  412.719122] acpi ACPI0007:0b: PM: direct-complete suspend driver flags: 0
[  412.719124] acpi ACPI0007:0a: PM: direct-complete suspend driver flags: 0
[  412.719126] acpi ACPI0007:09: PM: direct-complete suspend driver flags: 0
[  412.719128] acpi ACPI0007:08: PM: direct-complete suspend driver flags: 0
[  412.719129] acpi ACPI0007:07: PM: direct-complete suspend driver flags: 0
[  412.719131] acpi ACPI0007:06: PM: direct-complete suspend driver flags: 0
[  412.719133] acpi ACPI0007:05: PM: direct-complete suspend driver flags: 0
[  412.719136] acpi ACPI0007:04: PM: direct-complete suspend driver flags: 0
[  412.719138] acpi ACPI0007:03: PM: direct-complete suspend driver flags: 0
[  412.719140] acpi ACPI0007:02: PM: direct-complete suspend driver flags: 0
[  412.719141] acpi ACPI0007:01: PM: direct-complete suspend driver flags: 0
[  412.719143] acpi ACPI0007:00: PM: direct-complete suspend driver flags: 0
[  412.719148] acpi ACPI0010:00: PM: direct-complete suspend driver flags: 0
[  412.719151] button PNP0C0C:00: PM: driver suspend, may wakeup driver flags: 0
[  412.719154] acpi device:3e: PM: direct-complete suspend driver flags: 0
[  412.719156] acpi device:3d: PM: direct-complete suspend driver flags: 0
[  412.719158] acpi device:3c: PM: direct-complete suspend driver flags: 0
[  412.719160] acpi device:3b: PM: direct-complete suspend driver flags: 0
[  412.719163] acpi device:3a: PM: direct-complete suspend driver flags: 0
[  412.719165] acpi device:39: PM: direct-complete suspend driver flags: 0
[  412.719167] acpi device:38: PM: direct-complete suspend driver flags: 0
[  412.719169] acpi device:37: PM: direct-complete suspend driver flags: 0
[  412.719171] acpi device:36: PM: direct-complete suspend driver flags: 0
[  412.719174] acpi device:35: PM: direct-complete suspend driver flags: 0
[  412.719176] acpi device:34: PM: direct-complete suspend driver flags: 0
[  412.719178] acpi HPIC0003:00: PM: direct-complete suspend driver flags: 0
[  412.719180] acpi PNP0500:03: PM: direct-complete suspend driver flags: 0
[  412.719182] acpi PNP0500:02: PM: direct-complete suspend driver flags: 0
[  412.719184] acpi PNP0500:01: PM: direct-complete suspend driver flags: 0
[  412.719186] acpi PNP0500:00: PM: direct-complete suspend driver flags: 0
[  412.719187] acpi device:33: PM: direct-complete suspend driver flags: 0
[  412.719190] acpi device:32: PM: direct-complete suspend driver flags: 0
[  412.719192] acpi device:31: PM: direct-complete suspend driver flags: 0
[  412.719194] acpi device:30: PM: direct-complete suspend driver flags: 0
[  412.719196] acpi device:2f: PM: direct-complete suspend driver flags: 0
[  412.719198] acpi LNXPOWER:06: PM: direct-complete suspend driver flags: 0
[  412.719200] acpi device:2e: PM: direct-complete suspend driver flags: 0
[  412.719203] acpi device:2d: PM: direct-complete suspend driver flags: 0
[  412.719205] acpi device:2c: PM: direct-complete suspend driver flags: 0
[  412.719207] acpi PNP0C02:02: PM: direct-complete suspend driver flags: 0
[  412.719209] acpi SYNA3290:00: PM: direct-complete suspend driver flags: 0
[  412.719211] acpi HPQ8001:00: PM: direct-complete suspend driver flags: 0
[  412.719215] acpi ACPI0003:00: PM: direct-complete suspend driver flags: 0
[  412.719218] ec PNP0C09:00: PM: driver suspend driver flags: 0
[  412.719221] acpi PNP0800:00: PM: direct-complete suspend driver flags: 0
[  412.719223] acpi PNP0B00:00: PM: direct-complete suspend driver flags: 0
[  412.719225] acpi PNP0100:00: PM: direct-complete suspend driver flags: 0
[  412.719227] acpi PNP0200:00: PM: direct-complete suspend driver flags: 0
[  412.719229] acpi PNP0000:00: PM: direct-complete suspend driver flags: 0
[  412.719234] acpi device:2a: PM: direct-complete suspend driver flags: 0
[  412.719236] acpi device:29: PM: direct-complete suspend driver flags: 0
[  412.719238] acpi device:28: PM: direct-complete suspend driver flags: 0
[  412.719240] acpi device:27: PM: direct-complete suspend driver flags: 0
[  412.719243] acpi device:26: PM: direct-complete suspend driver flags: 0
[  412.719245] acpi device:25: PM: direct-complete suspend driver flags: 0
[  412.719247] acpi LNXPOWER:05: PM: direct-complete suspend driver flags: 0
[  412.719249] acpi device:24: PM: direct-complete suspend driver flags: 0
[  412.719251] acpi LNXPOWER:04: PM: direct-complete suspend driver flags: 0
[  412.719253] acpi device:23: PM: direct-complete suspend driver flags: 0
[  412.719255] acpi device:22: PM: direct-complete suspend driver flags: 0
[  412.719257] acpi device:21: PM: direct-complete suspend driver flags: 0
[  412.719259] acpi device:20: PM: direct-complete suspend driver flags: 0
[  412.719261] acpi device:1f: PM: direct-complete suspend driver flags: 0
[  412.719264] acpi device:1e: PM: direct-complete suspend driver flags: 0
[  412.719266] acpi device:1d: PM: direct-complete suspend driver flags: 0
[  412.719268] acpi device:1c: PM: direct-complete suspend driver flags: 0
[  412.719270] acpi device:1b: PM: direct-complete suspend driver flags: 0
[  412.719273] acpi device:1a: PM: direct-complete suspend driver flags: 0
[  412.719275] acpi LNXPOWER:03: PM: direct-complete suspend driver flags: 0
[  412.719277] acpi LNXPOWER:02: PM: direct-complete suspend driver flags: 0
[  412.719279] acpi device:19: PM: direct-complete suspend driver flags: 0
[  412.719280] acpi device:18: PM: direct-complete suspend driver flags: 0
[  412.719283] acpi device:17: PM: direct-complete suspend driver flags: 0
[  412.719285] acpi device:16: PM: direct-complete suspend driver flags: 0
[  412.719286] acpi device:15: PM: direct-complete suspend driver flags: 0
[  412.719289] acpi device:14: PM: direct-complete suspend driver flags: 0
[  412.719291] acpi device:13: PM: direct-complete suspend driver flags: 0
[  412.719292] acpi device:12: PM: direct-complete suspend driver flags: 0
[  412.719295] acpi device:11: PM: direct-complete suspend driver flags: 0
[  412.719298] acpi device:10: PM: direct-complete suspend driver flags: 0
[  412.719300] acpi LNXPOWER:01: PM: direct-complete suspend driver flags: 0
[  412.719302] acpi LNXPOWER:00: PM: direct-complete suspend driver flags: 0
[  412.719304] acpi device:0f: PM: direct-complete suspend driver flags: 0
[  412.719306] acpi device:0e: PM: direct-complete suspend driver flags: 0
[  412.719308] acpi PNP0C02:01: PM: direct-complete suspend driver flags: 0
[  412.719311] acpi device:0d: PM: direct-complete suspend driver flags: 0
[  412.719313] acpi device:0c: PM: direct-complete suspend driver flags: 0
[  412.719315] acpi device:0b: PM: direct-complete suspend driver flags: 0
[  412.719322] acpi device:09: PM: direct-complete suspend driver flags: 0
[  412.719325] acpi device:08: PM: direct-complete suspend driver flags: 0
[  412.719327] acpi device:07: PM: direct-complete suspend driver flags: 0
[  412.719329] acpi device:06: PM: direct-complete suspend driver flags: 0
[  412.719331] acpi device:05: PM: direct-complete suspend driver flags: 0
[  412.719333] acpi device:04: PM: direct-complete suspend driver flags: 0
[  412.719335] acpi device:03: PM: direct-complete suspend driver flags: 0
[  412.719337] acpi device:02: PM: direct-complete suspend driver flags: 0
[  412.719339] acpi device:01: PM: direct-complete suspend driver flags: 0
[  412.719341] acpi device:00: PM: direct-complete suspend driver flags: 0
[  412.719343] acpi PNP0C02:00: PM: direct-complete suspend driver flags: 0
[  412.719345] acpi PNP0C01:00: PM: direct-complete suspend driver flags: 0
[  412.719363] graphics fbcon: PM: direct-complete suspend driver flags: 0
[  412.719365] workqueue blkcg_punt_bio: PM: direct-complete suspend driver flags: 0
[  412.719367]  memory_tiering: PM: direct-complete suspend driver flags: 0
[  412.719369] workqueue writeback: PM: direct-complete suspend driver flags: 0
[  412.719372] dmi id: PM: direct-complete suspend driver flags: 0
[  412.719374] vtconsole vtcon0: PM: direct-complete suspend driver flags: 0
[  412.719376] regulator regulator.0: PM: class suspend driver flags: 0
[  412.719380]  workqueue: PM: direct-complete suspend driver flags: 0
[  412.719382]  container: PM: direct-complete suspend driver flags: 0
[  412.719384] processor cpu15: PM: direct-complete suspend driver flags: 0
[  412.719386] processor cpu14: PM: direct-complete suspend driver flags: 0
[  412.719388] processor cpu13: PM: direct-complete suspend driver flags: 0
[  412.719390] processor cpu12: PM: direct-complete suspend driver flags: 0
[  412.719393] processor cpu11: PM: direct-complete suspend driver flags: 0
[  412.719395] processor cpu10: PM: direct-complete suspend driver flags: 0
[  412.719397] processor cpu9: PM: direct-complete suspend driver flags: 0
[  412.719399] processor cpu8: PM: direct-complete suspend driver flags: 0
[  412.719401] processor cpu7: PM: direct-complete suspend driver flags: 0
[  412.719404] processor cpu6: PM: direct-complete suspend driver flags: 0
[  412.719406] processor cpu5: PM: direct-complete suspend driver flags: 0
[  412.719408] processor cpu4: PM: direct-complete suspend driver flags: 0
[  412.719410] processor cpu3: PM: direct-complete suspend driver flags: 0
[  412.719412] processor cpu2: PM: direct-complete suspend driver flags: 0
[  412.719414] processor cpu1: PM: direct-complete suspend driver flags: 0
[  412.719416] processor cpu0: PM: direct-complete suspend driver flags: 0
[  412.719418]  cpu: PM: direct-complete suspend driver flags: 0
[  412.719420] node node0: PM: direct-complete suspend driver flags: 0
[  412.719422]  node: PM: direct-complete suspend driver flags: 0
[  412.719424] memory memory131: PM: direct-complete suspend driver flags: 0
[  412.719426] memory memory130: PM: direct-complete suspend driver flags: 0
[  412.719428] memory memory129: PM: direct-complete suspend driver flags: 0
[  412.719430] memory memory128: PM: direct-complete suspend driver flags: 0
[  412.719432] memory memory127: PM: direct-complete suspend driver flags: 0
[  412.719434] memory memory126: PM: direct-complete suspend driver flags: 0
[  412.719436] memory memory125: PM: direct-complete suspend driver flags: 0
[  412.719437] memory memory124: PM: direct-complete suspend driver flags: 0
[  412.719439] memory memory123: PM: direct-complete suspend driver flags: 0
[  412.719441] memory memory122: PM: direct-complete suspend driver flags: 0
[  412.719443] memory memory121: PM: direct-complete suspend driver flags: 0
[  412.719445] memory memory120: PM: direct-complete suspend driver flags: 0
[  412.719447] memory memory119: PM: direct-complete suspend driver flags: 0
[  412.719449] memory memory118: PM: direct-complete suspend driver flags: 0
[  412.719451] memory memory117: PM: direct-complete suspend driver flags: 0
[  412.719453] memory memory116: PM: direct-complete suspend driver flags: 0
[  412.719454] memory memory115: PM: direct-complete suspend driver flags: 0
[  412.719456] memory memory114: PM: direct-complete suspend driver flags: 0
[  412.719458] memory memory113: PM: direct-complete suspend driver flags: 0
[  412.719460] memory memory112: PM: direct-complete suspend driver flags: 0
[  412.719462] memory memory111: PM: direct-complete suspend driver flags: 0
[  412.719464] memory memory110: PM: direct-complete suspend driver flags: 0
[  412.719466] memory memory109: PM: direct-complete suspend driver flags: 0
[  412.719468] memory memory108: PM: direct-complete suspend driver flags: 0
[  412.719470] memory memory107: PM: direct-complete suspend driver flags: 0
[  412.719471] memory memory106: PM: direct-complete suspend driver flags: 0
[  412.719473] memory memory105: PM: direct-complete suspend driver flags: 0
[  412.719475] memory memory104: PM: direct-complete suspend driver flags: 0
[  412.719477] memory memory103: PM: direct-complete suspend driver flags: 0
[  412.719479] memory memory102: PM: direct-complete suspend driver flags: 0
[  412.719481] memory memory101: PM: direct-complete suspend driver flags: 0
[  412.719483] memory memory100: PM: direct-complete suspend driver flags: 0
[  412.719485] memory memory99: PM: direct-complete suspend driver flags: 0
[  412.719486] memory memory98: PM: direct-complete suspend driver flags: 0
[  412.719488] memory memory97: PM: direct-complete suspend driver flags: 0
[  412.719490] memory memory96: PM: direct-complete suspend driver flags: 0
[  412.719492] memory memory95: PM: direct-complete suspend driver flags: 0
[  412.719494] memory memory94: PM: direct-complete suspend driver flags: 0
[  412.719496] memory memory93: PM: direct-complete suspend driver flags: 0
[  412.719498] memory memory92: PM: direct-complete suspend driver flags: 0
[  412.719500] memory memory91: PM: direct-complete suspend driver flags: 0
[  412.719501] memory memory90: PM: direct-complete suspend driver flags: 0
[  412.719503] memory memory89: PM: direct-complete suspend driver flags: 0
[  412.719506] memory memory88: PM: direct-complete suspend driver flags: 0
[  412.719508] memory memory87: PM: direct-complete suspend driver flags: 0
[  412.719510] memory memory86: PM: direct-complete suspend driver flags: 0
[  412.719512] memory memory85: PM: direct-complete suspend driver flags: 0
[  412.719513] memory memory84: PM: direct-complete suspend driver flags: 0
[  412.719515] memory memory83: PM: direct-complete suspend driver flags: 0
[  412.719517] memory memory82: PM: direct-complete suspend driver flags: 0
[  412.719519] memory memory81: PM: direct-complete suspend driver flags: 0
[  412.719521] memory memory80: PM: direct-complete suspend driver flags: 0
[  412.719523] memory memory79: PM: direct-complete suspend driver flags: 0
[  412.719525] memory memory78: PM: direct-complete suspend driver flags: 0
[  412.719527] memory memory77: PM: direct-complete suspend driver flags: 0
[  412.719529] memory memory76: PM: direct-complete suspend driver flags: 0
[  412.719530] memory memory75: PM: direct-complete suspend driver flags: 0
[  412.719533] memory memory74: PM: direct-complete suspend driver flags: 0
[  412.719534] memory memory73: PM: direct-complete suspend driver flags: 0
[  412.719536] memory memory72: PM: direct-complete suspend driver flags: 0
[  412.719538] memory memory71: PM: direct-complete suspend driver flags: 0
[  412.719540] memory memory70: PM: direct-complete suspend driver flags: 0
[  412.719542] memory memory69: PM: direct-complete suspend driver flags: 0
[  412.719544] memory memory68: PM: direct-complete suspend driver flags: 0
[  412.719545] memory memory67: PM: direct-complete suspend driver flags: 0
[  412.719547] memory memory66: PM: direct-complete suspend driver flags: 0
[  412.719549] memory memory65: PM: direct-complete suspend driver flags: 0
[  412.719551] memory memory64: PM: direct-complete suspend driver flags: 0
[  412.719553] memory memory63: PM: direct-complete suspend driver flags: 0
[  412.719555] memory memory62: PM: direct-complete suspend driver flags: 0
[  412.719557] memory memory61: PM: direct-complete suspend driver flags: 0
[  412.719559] memory memory60: PM: direct-complete suspend driver flags: 0
[  412.719561] memory memory59: PM: direct-complete suspend driver flags: 0
[  412.719563] memory memory58: PM: direct-complete suspend driver flags: 0
[  412.719565] memory memory57: PM: direct-complete suspend driver flags: 0
[  412.719567] memory memory56: PM: direct-complete suspend driver flags: 0
[  412.719569] memory memory55: PM: direct-complete suspend driver flags: 0
[  412.719571] memory memory54: PM: direct-complete suspend driver flags: 0
[  412.719572] memory memory53: PM: direct-complete suspend driver flags: 0
[  412.719574] memory memory52: PM: direct-complete suspend driver flags: 0
[  412.719576] memory memory51: PM: direct-complete suspend driver flags: 0
[  412.719578] memory memory50: PM: direct-complete suspend driver flags: 0
[  412.719580] memory memory49: PM: direct-complete suspend driver flags: 0
[  412.719582] memory memory48: PM: direct-complete suspend driver flags: 0
[  412.719583] memory memory47: PM: direct-complete suspend driver flags: 0
[  412.719585] memory memory46: PM: direct-complete suspend driver flags: 0
[  412.719587] memory memory45: PM: direct-complete suspend driver flags: 0
[  412.719589] memory memory44: PM: direct-complete suspend driver flags: 0
[  412.719591] memory memory43: PM: direct-complete suspend driver flags: 0
[  412.719593] memory memory42: PM: direct-complete suspend driver flags: 0
[  412.719595] memory memory41: PM: direct-complete suspend driver flags: 0
[  412.719597] memory memory40: PM: direct-complete suspend driver flags: 0
[  412.719599] memory memory39: PM: direct-complete suspend driver flags: 0
[  412.719601] memory memory38: PM: direct-complete suspend driver flags: 0
[  412.719603] memory memory37: PM: direct-complete suspend driver flags: 0
[  412.719605] memory memory36: PM: direct-complete suspend driver flags: 0
[  412.719607] memory memory35: PM: direct-complete suspend driver flags: 0
[  412.719608] memory memory34: PM: direct-complete suspend driver flags: 0
[  412.719610] memory memory33: PM: direct-complete suspend driver flags: 0
[  412.719612] memory memory32: PM: direct-complete suspend driver flags: 0
[  412.719614] memory memory23: PM: direct-complete suspend driver flags: 0
[  412.719616] memory memory22: PM: direct-complete suspend driver flags: 0
[  412.719618] memory memory21: PM: direct-complete suspend driver flags: 0
[  412.719620] memory memory20: PM: direct-complete suspend driver flags: 0
[  412.719621] memory memory19: PM: direct-complete suspend driver flags: 0
[  412.719623] memory memory18: PM: direct-complete suspend driver flags: 0
[  412.719625] memory memory17: PM: direct-complete suspend driver flags: 0
[  412.719627] memory memory16: PM: direct-complete suspend driver flags: 0
[  412.719629] memory memory15: PM: direct-complete suspend driver flags: 0
[  412.719630] memory memory14: PM: direct-complete suspend driver flags: 0
[  412.719632] memory memory13: PM: direct-complete suspend driver flags: 0
[  412.719634] memory memory12: PM: direct-complete suspend driver flags: 0
[  412.719636] memory memory11: PM: direct-complete suspend driver flags: 0
[  412.719638] memory memory10: PM: direct-complete suspend driver flags: 0
[  412.719640] memory memory9: PM: direct-complete suspend driver flags: 0
[  412.719642] memory memory8: PM: direct-complete suspend driver flags: 0
[  412.719644] memory memory7: PM: direct-complete suspend driver flags: 0
[  412.719646] memory memory6: PM: direct-complete suspend driver flags: 0
[  412.719647] memory memory5: PM: direct-complete suspend driver flags: 0
[  412.719649] memory memory4: PM: direct-complete suspend driver flags: 0
[  412.719651] memory memory3: PM: direct-complete suspend driver flags: 0
[  412.719653] memory memory2: PM: direct-complete suspend driver flags: 0
[  412.719655] memory memory1: PM: direct-complete suspend driver flags: 0
[  412.719657] memory memory0: PM: direct-complete suspend driver flags: 0
[  412.719659]  memory: PM: direct-complete suspend driver flags: 0
[  412.726501] amdgpu 0000:03:00.0: PM: bus suspend driver flags: 0
[  412.729504] snd_hda_intel 0000:03:00.6: PM: bus suspend driver flags: 0
[  412.734974] iwlwifi 0000:01:00.0: PM: bus suspend driver flags: 0
[  412.735006] pcieport 0000:00:02.2: PM: bus suspend driver flags: 5
[  412.740353] xhci_hcd 0000:03:00.3: PM: bus suspend, may wakeup driver flags: 0
[  412.741103] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  412.742524] scsi target0:0:0: PM: bus suspend driver flags: 0
[  412.742533] scsi host0: PM: bus suspend driver flags: 0
[  412.742580] usb 4-1: PM: type suspend driver flags: 0
[  412.764649] usb usb4: PM: type suspend driver flags: 0
[  412.772799] pcieport 0000:00:02.4: PM: bus suspend driver flags: 5
[  412.827488] usb usb3: PM: type suspend driver flags: 0
[  412.838129] xhci_hcd 0000:03:00.4: PM: bus suspend, may wakeup driver flags: 0
[  412.838377] pcieport 0000:00:08.1: PM: bus suspend, may wakeup driver flags: 5
[  412.838559] PM: suspend of devices complete after 127.095 msecs
[  412.838570] PM: start suspend of devices complete after 391.448 msecs
[  412.839672] pcie_mp2_amd 0000:03:00.7: PM: late bus suspend driver flags: 0
[  412.839674] ccp 0000:03:00.2: PM: late bus suspend driver flags: 0
[  412.839676] pci 0000:00:18.7: PM: late bus suspend driver flags: 0
[  412.839677] pci 0000:00:18.6: PM: late bus suspend driver flags: 0
[  412.839678] pci 0000:00:18.5: PM: late bus suspend driver flags: 0
[  412.839678] pci 0000:00:18.4: PM: late bus suspend driver flags: 0
[  412.839679] pci 0000:00:18.2: PM: late bus suspend driver flags: 0
[  412.839679] pci 0000:00:18.1: PM: late bus suspend driver flags: 0
[  412.839681] pci 0000:00:18.0: PM: late bus suspend driver flags: 0
[  412.839681] pci 0000:00:08.0: PM: late bus suspend driver flags: 0
[  412.839683] pci 0000:00:02.0: PM: late bus suspend driver flags: 0
[  412.839684] pci 0000:00:01.0: PM: late bus suspend driver flags: 0
[  412.839685] pci 0000:00:00.0: PM: late bus suspend driver flags: 0
[  412.839815] iwlwifi 0000:01:00.0: PM: late bus suspend driver flags: 0
[  412.839820] snd_hda_intel 0000:03:00.1: PM: late bus suspend driver flags: 0
[  412.839835] xhci_hcd 0000:03:00.3: PM: late bus suspend, may wakeup driver flags: 0
[  412.839845] snd_hda_intel 0000:03:00.6: PM: late bus suspend driver flags: 0
[  412.839872] snd_rn_pci_acp3x 0000:03:00.5: PM: late bus suspend driver flags: 0
[  412.839885] k10temp 0000:00:18.3: PM: late bus suspend driver flags: 0
[  412.839912] piix4_smbus 0000:00:14.0: PM: late bus suspend driver flags: 0
[  412.839970] amdgpu 0000:03:00.0: PM: late bus suspend driver flags: 0
[  412.840340] xhci_hcd 0000:03:00.4: PM: late bus suspend, may wakeup driver flags: 0
[  412.840490] i2c_hid_acpi i2c-ELAN074E:00: PM: late power domain suspend, may wakeup driver flags: 0
[  412.840505] nvme 0000:02:00.0: PM: late bus suspend driver flags: 0
[  412.840520] i2c_designware AMDI0010:03: PM: late power domain suspend driver flags: 6
[  412.840648] pci 0000:00:00.2: PM: late bus suspend driver flags: 0
[  412.840732] acpi-wmi PNP0C14:04: PM: late power domain suspend driver flags: 0
[  412.840738] amd_pmc AMDI0005:00: PM: late power domain suspend driver flags: 0
[  412.840741] ucsi_acpi USBC000:00: PM: late power domain suspend driver flags: 0
[  412.840745] acpi-wmi PNP0C14:03: PM: late power domain suspend driver flags: 0
[  412.840749] acpi-wmi PNP0C14:02: PM: late power domain suspend driver flags: 0
[  412.840752] acpi-wmi PNP0C14:01: PM: late power domain suspend driver flags: 0
[  412.840755] acpi-wmi PNP0C14:00: PM: late power domain suspend driver flags: 0
[  412.840759] amd_gpio AMDI0030:00: PM: late power domain suspend driver flags: 0
[  412.840772] Disabling GPIO #9 interrupt for suspend.
[  412.840794] ac ACPI0003:00: PM: late power domain suspend driver flags: 0
[  412.840804] pci 0000:00:14.3: PM: late bus suspend driver flags: 0
[  412.840809] pcieport 0000:00:02.4: PM: late bus suspend driver flags: 5
[  412.840809] pcieport 0000:00:08.1: PM: late bus suspend, may wakeup driver flags: 5
[  412.840825] pcieport 0000:00:02.2: PM: late bus suspend driver flags: 5
[  412.841160] PM: late suspend of devices complete after 2.583 msecs
[  412.841845] pcie_mp2_amd 0000:03:00.7: PM: noirq bus suspend driver flags: 0
[  412.841847] ccp 0000:03:00.2: PM: noirq bus suspend driver flags: 0
[  412.841848] pci 0000:00:18.6: PM: noirq bus suspend driver flags: 0
[  412.841848] pci 0000:00:18.7: PM: noirq bus suspend driver flags: 0
[  412.841849] pci 0000:00:18.5: PM: noirq bus suspend driver flags: 0
[  412.841850] pci 0000:00:18.4: PM: noirq bus suspend driver flags: 0
[  412.841850] pci 0000:00:18.2: PM: noirq bus suspend driver flags: 0
[  412.841852] pci 0000:00:18.1: PM: noirq bus suspend driver flags: 0
[  412.841853] pci 0000:00:18.0: PM: noirq bus suspend driver flags: 0
[  412.841855] pci 0000:00:08.0: PM: noirq bus suspend driver flags: 0
[  412.841855] pci 0000:00:02.0: PM: noirq bus suspend driver flags: 0
[  412.841856] pci 0000:00:01.0: PM: noirq bus suspend driver flags: 0
[  412.841857] pci 0000:00:00.0: PM: noirq bus suspend driver flags: 0
[  412.841935] snd_hda_intel 0000:03:00.1: PM: noirq bus suspend driver flags: 0
[  412.841982] snd_rn_pci_acp3x 0000:03:00.5: PM: noirq bus suspend driver flags: 0
[  412.841984] iwlwifi 0000:01:00.0: PM: noirq bus suspend driver flags: 0
[  412.841989] snd_hda_intel 0000:03:00.6: PM: noirq bus suspend driver flags: 0
[  412.841999] xhci_hcd 0000:03:00.3: PM: noirq bus suspend, may wakeup driver flags: 0
[  412.842004] k10temp 0000:00:18.3: PM: noirq bus suspend driver flags: 0
[  412.842005] piix4_smbus 0000:00:14.0: PM: noirq bus suspend driver flags: 0
[  412.842202] acpi-wmi PNP0C14:04: PM: noirq power domain suspend driver flags: 0
[  412.842206] amd_pmc AMDI0005:00: PM: noirq power domain suspend driver flags: 0
[  412.842209] ucsi_acpi USBC000:00: PM: noirq power domain suspend driver flags: 0
[  412.842212] acpi-wmi PNP0C14:03: PM: noirq power domain suspend driver flags: 0
[  412.842214] acpi-wmi PNP0C14:02: PM: noirq power domain suspend driver flags: 0
[  412.842216] acpi-wmi PNP0C14:01: PM: noirq power domain suspend driver flags: 0
[  412.842218] acpi-wmi PNP0C14:00: PM: noirq power domain suspend driver flags: 0
[  412.842221] amd_gpio AMDI0030:00: PM: noirq power domain suspend driver flags: 0
[  412.842226] ac ACPI0003:00: PM: noirq power domain suspend driver flags: 0
[  412.842256] nvme 0000:02:00.0: PM: noirq bus suspend driver flags: 0
[  412.842259] pci 0000:00:00.2: PM: noirq bus suspend driver flags: 0
[  412.842260] i2c_hid_acpi i2c-ELAN074E:00: PM: noirq power domain suspend, may wakeup driver flags: 0
[  412.842264] i2c_designware AMDI0010:03: PM: noirq power domain suspend driver flags: 6
[  412.842264] pci 0000:00:14.3: PM: noirq bus suspend driver flags: 0
[  412.842283] xhci_hcd 0000:03:00.4: PM: noirq bus suspend, may wakeup driver flags: 0
[  412.842346] ec PNP0C09:00: PM: noirq driver suspend driver flags: 0
[  412.842348] ACPI: EC: interrupt blocked
[  412.855922] amdgpu 0000:03:00.0: PM: noirq bus suspend driver flags: 0
[  412.871889] pcieport 0000:00:02.2: PM: noirq bus suspend driver flags: 5
[  412.871908] pcieport 0000:00:02.4: PM: noirq bus suspend driver flags: 5
[  412.879463] pcieport 0000:00:08.1: PM: noirq bus suspend, may wakeup driver flags: 5
[  412.884462] PM: noirq suspend of devices complete after 43.009 msecs
[  412.884936] ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
[  412.891758] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
[  412.892173] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
[  412.893577] amd_pmc AMDI0005:00: failed to set RTC: -22
[  412.893580] PM: suspend-to-idle
[  412.962190] PM: Triggering wakeup from IRQ 9
[  415.420648] amd_pmc: SMU idlemask s0i3: 0xc00e0eb5
[  415.420955] ACPI: PM: ACPI fixed event wakeup
[  415.420959] PM: resume from suspend-to-idle
[  415.422345] amd_pmc AMDI0005:00: Last suspend didn't reach deepest state
[  415.422573] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
[  415.427618] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
[  415.428871] ACPI: \_SB_.PEP_: Successfully transitioned to state screen on
[  415.429139] pci 0000:00:00.0: PM: noirq bus resume driver flags: 0
[  415.429176] pci 0000:00:00.2: PM: noirq bus resume driver flags: 0
[  415.429202] pci 0000:00:01.0: PM: noirq bus resume driver flags: 0
[  415.429223] pci 0000:00:02.0: PM: noirq bus resume driver flags: 0
[  415.429245] pcieport 0000:00:02.2: PM: noirq bus resume driver flags: 5
[  415.429395] pci 0000:00:08.0: PM: noirq bus resume driver flags: 0
[  415.429397] pcieport 0000:00:02.4: PM: noirq bus resume driver flags: 5
[  415.429447] pcieport 0000:00:08.1: PM: noirq bus resume driver flags: 5
[  415.429466] piix4_smbus 0000:00:14.0: PM: noirq bus resume driver flags: 0
[  415.429503] pci 0000:00:14.3: PM: noirq bus resume driver flags: 0
[  415.429513] pci 0000:00:18.0: PM: noirq bus resume driver flags: 0
[  415.429540] pci 0000:00:18.1: PM: noirq bus resume driver flags: 0
[  415.429545] pci 0000:00:18.2: PM: noirq bus resume driver flags: 0
[  415.429551] k10temp 0000:00:18.3: PM: noirq bus resume driver flags: 0
[  415.429557] pci 0000:00:18.4: PM: noirq bus resume driver flags: 0
[  415.429573] pci 0000:00:18.6: PM: noirq bus resume driver flags: 0
[  415.429574] pci 0000:00:18.5: PM: noirq bus resume driver flags: 0
[  415.429581] pci 0000:00:18.7: PM: noirq bus resume driver flags: 0
[  415.429588] i2c_designware AMDI0010:03: PM: noirq power domain resume driver flags: 6
[  415.429589] amdgpu 0000:03:00.0: PM: noirq bus resume driver flags: 0
[  415.429612] xhci_hcd 0000:03:00.4: PM: noirq bus resume driver flags: 0
[  415.429612] xhci_hcd 0000:03:00.3: PM: noirq bus resume driver flags: 0
[  415.429613] ccp 0000:03:00.2: PM: noirq bus resume driver flags: 0
[  415.429617] ec PNP0C09:00: PM: noirq driver resume driver flags: 0
[  415.429619] snd_rn_pci_acp3x 0000:03:00.5: PM: noirq bus resume driver flags: 0
[  415.429621] ACPI: EC: interrupt unblocked
[  415.429633] snd_hda_intel 0000:03:00.6: PM: noirq bus resume driver flags: 0
[  415.429657] pcie_mp2_amd 0000:03:00.7: PM: noirq bus resume driver flags: 0
[  415.429754] i2c_hid_acpi i2c-ELAN074E:00: PM: noirq power domain resume driver flags: 0
[  415.430204] ac ACPI0003:00: PM: noirq power domain resume driver flags: 0
[  415.430210] amd_gpio AMDI0030:00: PM: noirq power domain resume driver flags: 0
[  415.430215] acpi-wmi PNP0C14:00: PM: noirq power domain resume driver flags: 0
[  415.430217] acpi-wmi PNP0C14:01: PM: noirq power domain resume driver flags: 0
[  415.430220] acpi-wmi PNP0C14:02: PM: noirq power domain resume driver flags: 0
[  415.430225] acpi-wmi PNP0C14:03: PM: noirq power domain resume driver flags: 0
[  415.430230] ucsi_acpi USBC000:00: PM: noirq power domain resume driver flags: 0
[  415.430235] amd_pmc AMDI0005:00: PM: noirq power domain resume driver flags: 0
[  415.430241] acpi-wmi PNP0C14:04: PM: noirq power domain resume driver flags: 0
[  415.430398] i8042 i8042: PM: noirq driver resume driver flags: 0
[  415.440765] nvme 0000:02:00.0: PM: noirq bus resume driver flags: 0
[  415.441808] iwlwifi 0000:01:00.0: PM: noirq bus resume driver flags: 0
[  415.441809] snd_hda_intel 0000:03:00.1: PM: noirq bus resume driver flags: 0
[  415.468770] PM: noirq resume of devices complete after 39.894 msecs
[  415.469231] pci 0000:00:01.0: PM: early bus resume driver flags: 0
[  415.469231] pci 0000:00:00.2: PM: early bus resume driver flags: 0
[  415.469231] pci 0000:00:00.0: PM: early bus resume driver flags: 0
[  415.469249] pcieport 0000:00:02.2: PM: early bus resume driver flags: 5
[  415.469249] pci 0000:00:02.0: PM: early bus resume driver flags: 0
[  415.469250] pci 0000:00:08.0: PM: early bus resume driver flags: 0
[  415.469249] pcieport 0000:00:02.4: PM: early bus resume driver flags: 5
[  415.469266] pcieport 0000:00:08.1: PM: early bus resume driver flags: 5
[  415.469267] pci 0000:00:14.3: PM: early bus resume driver flags: 0
[  415.469267] pci 0000:00:18.0: PM: early bus resume driver flags: 0
[  415.469268] pci 0000:00:18.1: PM: early bus resume driver flags: 0
[  415.469267] piix4_smbus 0000:00:14.0: PM: early bus resume driver flags: 0
[  415.469296] pci 0000:00:18.4: PM: early bus resume driver flags: 0
[  415.469297] pci 0000:00:18.5: PM: early bus resume driver flags: 0
[  415.469297] pci 0000:00:18.6: PM: early bus resume driver flags: 0
[  415.469297] pci 0000:00:18.7: PM: early bus resume driver flags: 0
[  415.469297] pci 0000:00:18.2: PM: early bus resume driver flags: 0
[  415.469298] i2c_designware AMDI0010:03: PM: early power domain resume driver flags: 6
[  415.469297] k10temp 0000:00:18.3: PM: early bus resume driver flags: 0
[  415.469298] iwlwifi 0000:01:00.0: PM: early bus resume driver flags: 0
[  415.469306] nvme 0000:02:00.0: PM: early bus resume driver flags: 0
[  415.469308] amdgpu 0000:03:00.0: PM: early bus resume driver flags: 0
[  415.469309] xhci_hcd 0000:03:00.3: PM: early bus resume driver flags: 0
[  415.469309] ccp 0000:03:00.2: PM: early bus resume driver flags: 0
[  415.469310] xhci_hcd 0000:03:00.4: PM: early bus resume driver flags: 0
[  415.469311] snd_hda_intel 0000:03:00.6: PM: early bus resume driver flags: 0
[  415.469311] snd_rn_pci_acp3x 0000:03:00.5: PM: early bus resume driver flags: 0
[  415.469312] pcie_mp2_amd 0000:03:00.7: PM: early bus resume driver flags: 0
[  415.469317] snd_hda_intel 0000:03:00.1: PM: early bus resume driver flags: 0
[  415.469402] i2c_hid_acpi i2c-ELAN074E:00: PM: early power domain resume driver flags: 0
[  415.469977] ac ACPI0003:00: PM: early power domain resume driver flags: 0
[  415.469986] amd_gpio AMDI0030:00: PM: early power domain resume driver flags: 0
[  415.470025] acpi-wmi PNP0C14:00: PM: early power domain resume driver flags: 0
[  415.470028] acpi-wmi PNP0C14:01: PM: early power domain resume driver flags: 0
[  415.470032] acpi-wmi PNP0C14:02: PM: early power domain resume driver flags: 0
[  415.470036] acpi-wmi PNP0C14:03: PM: early power domain resume driver flags: 0
[  415.470041] ucsi_acpi USBC000:00: PM: early power domain resume driver flags: 0
[  415.470045] amd_pmc AMDI0005:00: PM: early power domain resume driver flags: 0
[  415.470051] acpi-wmi PNP0C14:04: PM: early power domain resume driver flags: 0
[  415.470461] PM: early resume of devices complete after 1.400 msecs
[  415.470538] pci 0000:00:00.0: PM: bus resume driver flags: 0
[  415.470545] pci 0000:00:01.0: PM: bus resume driver flags: 0
[  415.470545] pci 0000:00:00.2: PM: bus resume driver flags: 0
[  415.470548] pci 0000:00:02.0: PM: bus resume driver flags: 0
[  415.470551] pcieport 0000:00:02.2: PM: bus resume driver flags: 5
[  415.470556] pcieport 0000:00:08.1: PM: bus resume driver flags: 5
[  415.470556] pci 0000:00:08.0: PM: bus resume driver flags: 0
[  415.470556] pcieport 0000:00:02.4: PM: bus resume driver flags: 5
[  415.470561] piix4_smbus 0000:00:14.0: PM: bus resume driver flags: 0
[  415.470572] pci 0000:00:14.3: PM: bus resume driver flags: 0
[  415.470576] pci 0000:00:18.0: PM: bus resume driver flags: 0
[  415.470577] pci 0000:00:18.1: PM: bus resume driver flags: 0
[  415.470584] pci 0000:00:18.2: PM: bus resume driver flags: 0
[  415.470585] k10temp 0000:00:18.3: PM: bus resume driver flags: 0
[  415.470587] pci 0000:00:18.6: PM: bus resume driver flags: 0
[  415.470588] pci 0000:00:18.5: PM: bus resume driver flags: 0
[  415.470587] pci 0000:00:18.4: PM: bus resume driver flags: 0
[  415.470588] pci 0000:00:18.7: PM: bus resume driver flags: 0
[  415.470590] i2c_designware AMDI0010:03: PM: power domain resume driver flags: 6
[  415.470601] iwlwifi 0000:01:00.0: PM: bus resume driver flags: 0
[  415.470602] nvme 0000:02:00.0: PM: bus resume driver flags: 0
[  415.470612] i2c_hid_acpi i2c-ELAN074E:00: PM: power domain resume driver flags: 0
[  415.470690] regulator regulator.0: PM: class resume driver flags: 0
[  415.470769] ec PNP0C09:00: PM: driver resume driver flags: 0
[  415.470871] battery PNP0C0A:00: PM: driver resume driver flags: 0
[  415.470871] ieee80211 phy0: PM: class resume driver flags: 0
[  415.470949] button PNP0C0C:00: PM: driver resume driver flags: 0
[  415.471166] tpm_crb MSFT0101:00: PM: driver resume driver flags: 0
[  415.471171] button PNP0C0D:00: PM: driver resume driver flags: 0
[  415.471189] amdgpu 0000:03:00.0: PM: bus resume driver flags: 0
[  415.471197] ccp 0000:03:00.2: PM: bus resume driver flags: 0
[  415.471203] xhci_hcd 0000:03:00.3: PM: bus resume driver flags: 0
[  415.471217] xhci_hcd 0000:03:00.4: PM: bus resume driver flags: 0
[  415.471232] snd_rn_pci_acp3x 0000:03:00.5: PM: bus resume driver flags: 0
[  415.471239] snd_hda_intel 0000:03:00.6: PM: bus resume driver flags: 0
[  415.471258] pcie_mp2_amd 0000:03:00.7: PM: bus resume driver flags: 0
[  415.472480] thermal LNXTHERM:00: PM: driver resume driver flags: 0
[  415.472499] thermal LNXTHERM:01: PM: driver resume driver flags: 0
[  415.472526] usb usb1: PM: type resume driver flags: 0
[  415.472527] usb usb2: PM: type resume driver flags: 0
[  415.472529] platform PNP0800:00: PM: bus resume driver flags: 0
[  415.472533] platform PNP0C09:00: PM: bus resume driver flags: 0
[  415.472536] ac ACPI0003:00: PM: power domain resume driver flags: 0
[  415.472539] usb usb3: PM: type resume driver flags: 0
[  415.472552] usb usb4: PM: type resume driver flags: 0
[  415.472674] [drm] PCIE GART of 1024M enabled.
[  415.472675] [drm] PTB located at 0x000000F41FC00000
[  415.472958] usb 1-3: PM: type resume driver flags: 0
[  415.472969] usb 1-4: PM: type resume driver flags: 0
[  415.473232] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  415.475639] amdgpu 0000:03:00.0: amdgpu: dpm has been disabled
[  415.475684] snd_hda_codec_realtek hdaudioC1D0: PM: driver resume driver flags: 0
[  415.475795] platform PNP0C0A:00: PM: bus resume driver flags: 0
[  415.475797] platform HPIC0003:00: PM: bus resume driver flags: 0
[  415.475799] platform PNP0C0C:00: PM: bus resume driver flags: 0
[  415.475801] platform acpi-cpufreq: PM: bus resume driver flags: 0
[  415.475803] amd_gpio AMDI0030:00: PM: power domain resume driver flags: 0
[  415.475806] platform MSFT0101:00: PM: bus resume driver flags: 0
[  415.475807] acpi-wmi PNP0C14:00: PM: power domain resume driver flags: 0
[  415.475809] acpi-wmi PNP0C14:01: PM: power domain resume driver flags: 0
[  415.475811] acpi-wmi PNP0C14:02: PM: power domain resume driver flags: 0
[  415.475813] platform PNP0C0D:00: PM: bus resume driver flags: 0
[  415.475816] acpi-wmi PNP0C14:03: PM: power domain resume driver flags: 0
[  415.475819] platform ACPI000E:00: PM: bus resume driver flags: 0
[  415.475822] ucsi_acpi USBC000:00: PM: power domain resume driver flags: 0
[  415.475960] amd_pmc AMDI0005:00: PM: power domain resume driver flags: 0
[  415.475962] acpi-fan PNP0C0B:00: PM: bus resume driver flags: 0
[  415.475966] platform PNP0103:00: PM: bus resume driver flags: 0
[  415.475967] acpi-wmi PNP0C14:04: PM: power domain resume driver flags: 0
[  415.475972] platform rtc-efi.0: PM: bus resume driver flags: 0
[  415.475974] platform efivars.0: PM: bus resume driver flags: 0
[  415.475979] system 00:00: PM: bus resume driver flags: 0
[  415.475981] rtc_cmos 00:01: PM: bus resume driver flags: 0
[  415.475985] i8042 kbd 00:02: PM: bus resume driver flags: 0
[  415.475987] system 00:03: PM: bus resume driver flags: 0
[  415.476041] pcspkr pcspkr: PM: bus resume driver flags: 0
[  415.476080] serial8250 serial8250: PM: bus resume driver flags: 0
[  415.476085] port serial8250:0.0: PM: driver resume driver flags: 0
[  415.476088] port serial8250:0.1: PM: driver resume driver flags: 0
[  415.476091] port serial8250:0.2: PM: driver resume driver flags: 0
[  415.476094] port serial8250:0.3: PM: driver resume driver flags: 0
[  415.476100] i8042 i8042: PM: bus resume driver flags: 0
[  415.476105] atkbd serio0: PM: bus resume driver flags: 0
[  415.476110] rtc rtc0: PM: class resume driver flags: 0
[  415.476113] alarmtimer alarmtimer.0.auto: PM: bus resume driver flags: 0
[  415.476117] input input0: PM: type resume driver flags: 0
[  415.476122] leds input0::numlock: PM: class resume driver flags: 0
[  415.476124] leds input0::capslock: PM: class resume driver flags: 0
[  415.476126] leds input0::scrolllock: PM: class resume driver flags: 0
[  415.476139] platform microcode: PM: bus resume driver flags: 0
[  415.476156] input input1: PM: type resume driver flags: 0
[  415.476165] input input2: PM: type resume driver flags: 0
[  415.476169] input input3: PM: type resume driver flags: 0
[  415.477396] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[  415.484323] nvme nvme0: 8/0/0 default/read/poll queues
[  415.496304] usb 4-1: PM: type resume driver flags: 0
[  415.527517] usb 3-3: PM: type resume driver flags: 0
[  415.534294] input input7: PM: type resume driver flags: 0
[  415.534306] input input9: PM: type resume driver flags: 0
[  415.576911] scsi host0: PM: bus resume driver flags: 0
[  415.576932] scsi target0:0:0: PM: bus resume driver flags: 0
[  415.576951] sd 0:0:0:0: PM: bus resume driver flags: 0
[  415.629077] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[  415.629080] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  415.629081] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  415.629082] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[  415.629083] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[  415.629084] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[  415.629085] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[  415.629086] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[  415.629087] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[  415.629088] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
[  415.629089] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
[  415.629090] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
[  415.629092] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
[  415.629092] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
[  415.629093] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
[  415.641010] snd_hda_intel 0000:03:00.1: PM: bus resume driver flags: 0
[  415.641360] backlight amdgpu_bl0: PM: class resume driver flags: 0
[  415.641582] input input10: PM: type resume driver flags: 0
[  415.641607] sp5100-tco sp5100-tco: PM: bus resume driver flags: 0
[  415.641622] platform regulatory.0: PM: bus resume driver flags: 0
[  415.641635] acp_rn_pdm_dma acp_rn_pdm_dma.0: PM: bus resume driver flags: 0
[  415.641642] dmic-codec dmic-codec.0: PM: bus resume driver flags: 0
[  415.641647] input input11: PM: type resume driver flags: 0
[  415.641655] hp-wmi hp-wmi: PM: bus resume driver flags: 0
[  415.642544] rfkill rfkill0: PM: class resume driver flags: 0
[  415.642588] intel_rapl_msr intel_rapl_msr.0: PM: bus resume driver flags: 0
[  415.643275] input input12: PM: type resume driver flags: 0
[  415.643286] leds hda::mute: PM: class resume driver flags: 0
[  415.643311] input input13: PM: type resume driver flags: 0
[  415.643315] input input14: PM: type resume driver flags: 0
[  415.643323] acp_pdm_mach acp_pdm_mach.0: PM: bus resume driver flags: 0
[  415.643339] leds phy0-led: PM: class resume driver flags: 0
[  415.643342] rfkill rfkill1: PM: class resume driver flags: 0
[  415.643384] PM: resume of devices complete after 172.920 msecs
[  415.643536] snd_hda_codec_realtek hdaudioC1D0: PM: completing driver resume driver flags: 0
[  415.643543] snd_hda_codec_hdmi hdaudioC0D0: PM: completing driver resume driver flags: 0
[  415.643594] usb 4-1: PM: completing type resume driver flags: 0
[  415.643612] usb 1-4: PM: completing type resume driver flags: 0
[  415.643619] usb 3-3: PM: completing type resume driver flags: 0
[  415.643624] usb 1-3: PM: completing type resume driver flags: 0
[  415.643634] usb usb4: PM: completing type resume driver flags: 0
[  415.643642] usb usb3: PM: completing type resume driver flags: 0
[  415.643650] usb usb2: PM: completing type resume driver flags: 0
[  415.643660] usb usb1: PM: completing type resume driver flags: 0
[  415.643777] snd_hda_intel 0000:03:00.1: PM: completing bus resume driver flags: 0
[  415.643850] i2c_hid_acpi i2c-ELAN074E:00: PM: completing power domain resume driver flags: 0
[  415.643856] acpi-wmi PNP0C14:04: PM: completing power domain resume driver flags: 0
[  415.643860] amd_pmc AMDI0005:00: PM: completing power domain resume driver flags: 0
[  415.643862] ucsi_acpi USBC000:00: PM: completing power domain resume driver flags: 0
[  415.643865] acpi-wmi PNP0C14:03: PM: completing power domain resume driver flags: 0
[  415.643868] acpi-wmi PNP0C14:02: PM: completing power domain resume driver flags: 0
[  415.643869] acpi-wmi PNP0C14:01: PM: completing power domain resume driver flags: 0
[  415.643871] acpi-wmi PNP0C14:00: PM: completing power domain resume driver flags: 0
[  415.643874] i2c_designware AMDI0010:03: PM: completing power domain resume driver flags: 6
[  415.643877] amd_gpio AMDI0030:00: PM: completing power domain resume driver flags: 0
[  415.643882] ac ACPI0003:00: PM: completing power domain resume driver flags: 0
[  415.643885] pcie_mp2_amd 0000:03:00.7: PM: completing bus resume driver flags: 0
[  415.643887] snd_hda_intel 0000:03:00.6: PM: completing bus resume driver flags: 0
[  415.643891] snd_rn_pci_acp3x 0000:03:00.5: PM: completing bus resume driver flags: 0
[  415.643894] xhci_hcd 0000:03:00.4: PM: completing bus resume driver flags: 0
[  415.643995] xhci_hcd 0000:03:00.3: PM: completing bus resume driver flags: 0
[  415.644075] ccp 0000:03:00.2: PM: completing bus resume driver flags: 0
[  415.644077] amdgpu 0000:03:00.0: PM: completing bus resume driver flags: 0
[  415.644081] nvme 0000:02:00.0: PM: completing bus resume driver flags: 0
[  415.644084] iwlwifi 0000:01:00.0: PM: completing bus resume driver flags: 0
[  415.644087] pci 0000:00:18.7: PM: completing bus resume driver flags: 0
[  415.644089] pci 0000:00:18.6: PM: completing bus resume driver flags: 0
[  415.644090] pci 0000:00:18.5: PM: completing bus resume driver flags: 0
[  415.644092] pci 0000:00:18.4: PM: completing bus resume driver flags: 0
[  415.644094] k10temp 0000:00:18.3: PM: completing bus resume driver flags: 0
[  415.644095] pci 0000:00:18.2: PM: completing bus resume driver flags: 0
[  415.644098] pci 0000:00:18.1: PM: completing bus resume driver flags: 0
[  415.644099] pci 0000:00:18.0: PM: completing bus resume driver flags: 0
[  415.644101] pci 0000:00:14.3: PM: completing bus resume driver flags: 0
[  415.644103] piix4_smbus 0000:00:14.0: PM: completing bus resume driver flags: 0
[  415.644104] pcieport 0000:00:08.1: PM: completing bus resume driver flags: 5
[  415.644107] pci 0000:00:08.0: PM: completing bus resume driver flags: 0
[  415.644109] pcieport 0000:00:02.4: PM: completing bus resume driver flags: 5
[  415.644111] pcieport 0000:00:02.2: PM: completing bus resume driver flags: 5
[  415.644113] pci 0000:00:02.0: PM: completing bus resume driver flags: 0
[  415.644114] pci 0000:00:01.0: PM: completing bus resume driver flags: 0
[  415.644116] pci 0000:00:00.2: PM: completing bus resume driver flags: 0
[  415.644118] pci 0000:00:00.0: PM: completing bus resume driver flags: 0
[  415.645611] OOM killer enabled.
[  415.645615] Restarting tasks: Starting
[  415.647339] Restarting tasks: Done
[  415.647376] random: crng reseeded on system resumption
[  415.662626] PM: suspend exit
[  415.889960] wlp1s0: authenticate with d6:92:5e:eb:ee:15 (local address=c8:15:4e:63:1d:e8)
[  415.891467] wlp1s0: send auth to d6:92:5e:eb:ee:15 (try 1/3)
[  415.938640] wlp1s0: authenticated
[  415.943755] wlp1s0: associate with d6:92:5e:eb:ee:15 (try 1/3)
[  415.951411] wlp1s0: RX AssocResp from d6:92:5e:eb:ee:15 (capab=0x1011 status=0 aid=21)
[  415.963786] wlp1s0: associated
[  416.012734] wlp1s0: Limiting TX power to 23 (23 - 0) dBm as advertised by d6:92:5e:eb:ee:15
[  419.741790] PM: suspend entry (s2idle)
[  420.055335] Filesystems sync: 0.313 seconds
[  420.055818] Freezing user space processes
[  420.057833] Freezing user space processes completed (elapsed 0.002 seconds)
[  420.057837] OOM killer disabled.
[  420.057839] Freezing remaining freezable tasks
[  420.059100] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  420.059102] printk: Suspending console(s) (use no_console_suspend to debug)
[  420.313413] snd_hda_codec_hdmi hdaudioC0D0: PM: direct-complete suspend driver flags: 0
[  420.313432] dummy 3-0037: PM: direct-complete suspend driver flags: 0
[  420.313456] dummy 3-0036: PM: direct-complete suspend driver flags: 0
[  420.313479] scsi_device 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  420.313489] scsi_host host0: PM: direct-complete suspend driver flags: 0
[  420.313499]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313523]  ep_82: PM: direct-complete suspend driver flags: 0
[  420.313545]  ep_01: PM: direct-complete suspend driver flags: 0
[  420.313568] i2c i2c-8: PM: direct-complete suspend driver flags: 0
[  420.313579] i2c i2c-7: PM: direct-complete suspend driver flags: 0
[  420.313592] i2c i2c-6: PM: direct-complete suspend driver flags: 0
[  420.313603] i2c i2c-5: PM: direct-complete suspend driver flags: 0
[  420.313614] i2c i2c-4: PM: direct-complete suspend driver flags: 0
[  420.313625]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313641]  ep_04: PM: direct-complete suspend driver flags: 0
[  420.313861] net lo: PM: direct-complete suspend driver flags: 0
[  420.313871]  ep_84: PM: direct-complete suspend driver flags: 0
[  420.313874]  ep_03: PM: direct-complete suspend driver flags: 0
[  420.313875]  ep_83: PM: direct-complete suspend driver flags: 0
[  420.313878]  ep_02: PM: direct-complete suspend driver flags: 0
[  420.313880]  ep_82: PM: direct-complete suspend driver flags: 0
[  420.313883]  ep_01: PM: direct-complete suspend driver flags: 0
[  420.313887]  ep_81: PM: direct-complete suspend driver flags: 0
[  420.313888]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313889]  ep_83: PM: direct-complete suspend driver flags: 0
[  420.313889]  ep_03: PM: direct-complete suspend driver flags: 0
[  420.313891]  ep_82: PM: direct-complete suspend driver flags: 0
[  420.313892]  ep_02: PM: direct-complete suspend driver flags: 0
[  420.313892]  ep_81: PM: direct-complete suspend driver flags: 0
[  420.313895]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313899]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313899]  ep_87: PM: direct-complete suspend driver flags: 0
[  420.313899] uvcvideo 1-3:1.1: PM: direct-complete suspend driver flags: 0
[  420.313900]  ep_81: PM: direct-complete suspend driver flags: 0
[  420.313901]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313902]  ep_81: PM: direct-complete suspend driver flags: 0
[  420.313909]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313909] bdi 0:64: PM: direct-complete suspend driver flags: 0
[  420.313910]  ep_81: PM: direct-complete suspend driver flags: 0
[  420.313914]  ep_00: PM: direct-complete suspend driver flags: 0
[  420.313916]  ep_81: PM: direct-complete suspend driver flags: 0
[  420.313923] i2c i2c-2: PM: direct-complete suspend driver flags: 0
[  420.313924] i2c i2c-1: PM: direct-complete suspend driver flags: 0
[  420.313925] pcie_bwctrl 0000:00:08.1:pcie010: PM: direct-complete suspend driver flags: 0
[  420.313925] pcie_pme 0000:00:08.1:pcie001: PM: direct-complete suspend driver flags: 0
[  420.313925] pcie_bwctrl 0000:00:02.4:pcie010: PM: direct-complete suspend driver flags: 0
[  420.313927] pcie_pme 0000:00:02.4:pcie001: PM: direct-complete suspend driver flags: 0
[  420.313930] pcie_bwctrl 0000:00:02.2:pcie010: PM: direct-complete suspend driver flags: 0
[  420.313930] pcie_pme 0000:00:02.2:pcie001: PM: direct-complete suspend driver flags: 0
[  420.313931] pcie_mp2_amd 0000:03:00.7: PM: bus suspend driver flags: 0
[  420.313932] ccp 0000:03:00.2: PM: bus suspend driver flags: 0
[  420.313934] pci 0000:00:18.7: PM: bus suspend driver flags: 0
[  420.313935] pci 0000:00:18.6: PM: bus suspend driver flags: 0
[  420.313935] sound seq: PM: direct-complete suspend driver flags: 0
[  420.313936] pci 0000:00:18.5: PM: bus suspend driver flags: 0
[  420.313936] pci 0000:00:18.4: PM: bus suspend driver flags: 0
[  420.313936] pci 0000:00:18.2: PM: bus suspend driver flags: 0
[  420.313939] pci 0000:00:18.1: PM: bus suspend driver flags: 0
[  420.313939] pci 0000:00:18.0: PM: bus suspend driver flags: 0
[  420.313940] pci 0000:00:08.0: PM: bus suspend driver flags: 0
[  420.313942] pci 0000:00:02.0: PM: bus suspend driver flags: 0
[  420.313943] pci 0000:00:01.0: PM: bus suspend driver flags: 0
[  420.313943] pci 0000:00:00.0: PM: bus suspend driver flags: 0
[  420.313950] net br-bd31abe76a1b: PM: direct-complete suspend driver flags: 0
[  420.313954] net lo: PM: direct-complete suspend driver flags: 0
[  420.313955] btusb 3-3:1.1: PM: direct-complete suspend driver flags: 0
[  420.313956] usb 1-4:1.0: PM: direct-complete suspend driver flags: 0
[  420.313957] net docker0: PM: direct-complete suspend driver flags: 0
[  420.313961] ptp ptp0: PM: direct-complete suspend driver flags: 0
[  420.313969]  port0.0: PM: direct-complete suspend driver flags: 0
[  420.313972] usb 1-4: PM: type suspend driver flags: 0
[  420.313973]  4:variable_supply: PM: direct-complete suspend driver flags: 0
[  420.313975]  3:fixed_supply: PM: direct-complete suspend driver flags: 0
[  420.313977]  2:fixed_supply: PM: direct-complete suspend driver flags: 0
[  420.313978] usb usb2: PM: type suspend driver flags: 0
[  420.313979]  1:fixed_supply: PM: direct-complete suspend driver flags: 0
[  420.313982]  sink-capabilities: PM: direct-complete suspend driver flags: 0
[  420.313984]  1:fixed_supply: PM: direct-complete suspend driver flags: 0
[  420.313986]  source-capabilities: PM: direct-complete suspend driver flags: 0
[  420.313988] vc vcsa6: PM: direct-complete suspend driver flags: 0
[  420.313990] vc vcsu6: PM: direct-complete suspend driver flags: 0
[  420.313993] vc vcs6: PM: direct-complete suspend driver flags: 0
[  420.313996] vc vcsa5: PM: direct-complete suspend driver flags: 0
[  420.313999] vc vcsu5: PM: direct-complete suspend driver flags: 0
[  420.314003] vc vcs5: PM: direct-complete suspend driver flags: 0
[  420.314005] vc vcsa4: PM: direct-complete suspend driver flags: 0
[  420.314007] vc vcsu4: PM: direct-complete suspend driver flags: 0
[  420.314009] vc vcs4: PM: direct-complete suspend driver flags: 0
[  420.314011] vc vcsa3: PM: direct-complete suspend driver flags: 0
[  420.314013] vc vcsu3: PM: direct-complete suspend driver flags: 0
[  420.314016] vc vcs3: PM: direct-complete suspend driver flags: 0
[  420.314018] vc vcsa2: PM: direct-complete suspend driver flags: 0
[  420.314020] vc vcsu2: PM: direct-complete suspend driver flags: 0
[  420.314023] vc vcs2: PM: direct-complete suspend driver flags: 0
[  420.314025] net lo: PM: direct-complete suspend driver flags: 0
[  420.314027] net lo: PM: direct-complete suspend driver flags: 0
[  420.314029] net wlp1s0: PM: direct-complete suspend driver flags: 0
[  420.314033] rfkill rfkill1: PM: class suspend driver flags: 0
[  420.314043] leds phy0-led: PM: class suspend driver flags: 0
[  420.314049]  card2: PM: direct-complete suspend driver flags: 0
[  420.314053]  card2: PM: direct-complete suspend driver flags: 0
[  420.314055] ieee80211 phy0: PM: class suspend driver flags: 0
[  420.314057] sound controlC2: PM: direct-complete suspend driver flags: 0
[  420.314061] sound pcmC2D0c: PM: type suspend driver flags: 0
[  420.314067] wlp1s0: deauthenticating from d6:92:5e:eb:ee:15 by local choice (Reason: 3=DEAUTH_LEAVING)
[  420.314070]  acp3x-dmic-capture: PM: direct-complete suspend driver flags: 0
[  420.314073] acp_pdm_mach acp_pdm_mach.0: PM: bus suspend driver flags: 0
[  420.314092]  card1: PM: direct-complete suspend driver flags: 0
[  420.314095]  card1: PM: direct-complete suspend driver flags: 0
[  420.314098] sound controlC1: PM: direct-complete suspend driver flags: 0
[  420.314102] input event10: PM: direct-complete suspend driver flags: 0
[  420.314106] input input14: PM: type suspend driver flags: 0
[  420.314110] input event9: PM: direct-complete suspend driver flags: 0
[  420.314114] input input13: PM: type suspend driver flags: 0
[  420.314117] sound hwC1D0: PM: direct-complete suspend driver flags: 0
[  420.314120] sound pcmC1D0c: PM: type suspend driver flags: 0
[  420.314122] sound pcmC1D0p: PM: type suspend driver flags: 0
[  420.314129]  card0: PM: direct-complete suspend driver flags: 0
[  420.314131]  card0: PM: direct-complete suspend driver flags: 0
[  420.314133]  mic: PM: direct-complete suspend driver flags: 0
[  420.314137]  speaker: PM: direct-complete suspend driver flags: 0
[  420.314140] sound ctl-led: PM: direct-complete suspend driver flags: 0
[  420.314143] faux_driver snd-soc-dummy: PM: direct-complete suspend driver flags: 0
[  420.314147] leds hda::mute: PM: class suspend driver flags: 0
[  420.314173] media media0: PM: direct-complete suspend driver flags: 0
[  420.314177] snd_hda_codec_realtek hdaudioC1D0: PM: driver suspend driver flags: 0
[  420.314177] video4linux video1: PM: direct-complete suspend driver flags: 0
[  420.314180] video4linux video0: PM: direct-complete suspend driver flags: 0
[  420.314185] sound controlC0: PM: direct-complete suspend driver flags: 0
[  420.314188] input event8: PM: direct-complete suspend driver flags: 0
[  420.314191] input input12: PM: type suspend driver flags: 0
[  420.314193] uvcvideo 1-3:1.0: PM: direct-complete suspend driver flags: 0
[  420.314195] sound hwC0D0: PM: direct-complete suspend driver flags: 0
[  420.314198] sound pcmC0D3p: PM: type suspend driver flags: 0
[  420.314204] powercap intel-rapl:0:0: PM: direct-complete suspend driver flags: 0
[  420.314206] powercap intel-rapl:0: PM: direct-complete suspend driver flags: 0
[  420.314209] powercap intel-rapl: PM: direct-complete suspend driver flags: 0
[  420.314212] hwmon hwmon8: PM: direct-complete suspend driver flags: 0
[  420.314216] thermal thermal_zone2: PM: direct-complete suspend driver flags: 0
[  420.314220] intel_rapl_msr intel_rapl_msr.0: PM: bus suspend driver flags: 0
[  420.314223] misc kvm: PM: direct-complete suspend driver flags: 0
[  420.314224] usb 1-3: PM: type suspend driver flags: 0
[  420.314226] usb_power_delivery pd0: PM: direct-complete suspend driver flags: 0
[  420.314228] typec port0: PM: direct-complete suspend driver flags: 0
[  420.314229] snd_hda_intel 0000:03:00.1: PM: bus suspend driver flags: 0
[  420.314231] hwmon hwmon7: PM: direct-complete suspend driver flags: 0
[  420.314235] rfkill rfkill0: PM: class suspend driver flags: 0
[  420.314241] platform-profile platform-profile-0: PM: direct-complete suspend driver flags: 0
[  420.314245] hwmon hwmon6: PM: direct-complete suspend driver flags: 0
[  420.314250] hp-wmi hp-wmi: PM: bus suspend driver flags: 0
[  420.314252] usb usb1: PM: type suspend driver flags: 0
[  420.314254] input event7: PM: direct-complete suspend driver flags: 0
[  420.314258] input input11: PM: type suspend driver flags: 0
[  420.314263] dmic-codec dmic-codec.0: PM: bus suspend driver flags: 0
[  420.314266] acp_rn_pdm_dma acp_rn_pdm_dma.0: PM: bus suspend driver flags: 0
[  420.314269] nvmem 3-0051: PM: direct-complete suspend driver flags: 0
[  420.314273] snd_rn_pci_acp3x 0000:03:00.5: PM: bus suspend driver flags: 0
[  420.314273] nvmem 3-0050: PM: direct-complete suspend driver flags: 0
[  420.314273] usb 3-3: PM: type suspend driver flags: 0
[  420.314277] ee1004 3-0051: PM: direct-complete suspend driver flags: 0
[  420.314280] sound timer: PM: direct-complete suspend driver flags: 0
[  420.314281] ee1004 3-0050: PM: direct-complete suspend driver flags: 0
[  420.314284] scsi_generic sg0: PM: direct-complete suspend driver flags: 0
[  420.314287] platform regulatory.0: PM: bus suspend driver flags: 0
[  420.314290] event_source power_core: PM: direct-complete suspend driver flags: 0
[  420.314292] event_source power: PM: direct-complete suspend driver flags: 0
[  420.314294] watchdog watchdog0: PM: direct-complete suspend driver flags: 0
[  420.314296] misc watchdog: PM: direct-complete suspend driver flags: 0
[  420.314299] sp5100-tco sp5100-tco: PM: bus suspend driver flags: 0
[  420.314301] input event6: PM: direct-complete suspend driver flags: 0
[  420.314304] input input10: PM: type suspend driver flags: 0
[  420.314303] i2c i2c-3: PM: direct-complete suspend driver flags: 0
[  420.314307] hwmon hwmon5: PM: direct-complete suspend driver flags: 0
[  420.314314] hwmon hwmon4: PM: direct-complete suspend driver flags: 0
[  420.314317] k10temp 0000:00:18.3: PM: bus suspend driver flags: 0
[  420.314318] hwmon hwmon3: PM: direct-complete suspend driver flags: 0
[  420.314321] power_supply BAT0: PM: direct-complete suspend driver flags: 0
[  420.314323] misc rfkill: PM: direct-complete suspend driver flags: 0
[  420.314325] input event5: PM: direct-complete suspend driver flags: 0
[  420.314327] input event4: PM: direct-complete suspend driver flags: 0
[  420.314329] input event3: PM: direct-complete suspend driver flags: 0
[  420.314332] input event2: PM: direct-complete suspend driver flags: 0
[  420.314334] input event1: PM: direct-complete suspend driver flags: 0
[  420.314336] piix4_smbus 0000:00:14.0: PM: bus suspend driver flags: 0
[  420.314337] input event0: PM: direct-complete suspend driver flags: 0
[  420.314339] msr msr15: PM: direct-complete suspend driver flags: 0
[  420.314341] msr msr14: PM: direct-complete suspend driver flags: 0
[  420.314343] msr msr13: PM: direct-complete suspend driver flags: 0
[  420.314346] msr msr12: PM: direct-complete suspend driver flags: 0
[  420.314348] msr msr11: PM: direct-complete suspend driver flags: 0
[  420.314350] msr msr10: PM: direct-complete suspend driver flags: 0
[  420.314353] msr msr9: PM: direct-complete suspend driver flags: 0
[  420.314357] msr msr8: PM: direct-complete suspend driver flags: 0
[  420.314359] msr msr7: PM: direct-complete suspend driver flags: 0
[  420.314360] msr msr6: PM: direct-complete suspend driver flags: 0
[  420.314362] msr msr5: PM: direct-complete suspend driver flags: 0
[  420.314364] msr msr4: PM: direct-complete suspend driver flags: 0
[  420.314366] msr msr3: PM: direct-complete suspend driver flags: 0
[  420.314368] msr msr2: PM: direct-complete suspend driver flags: 0
[  420.314370] msr msr1: PM: direct-complete suspend driver flags: 0
[  420.314372] msr msr0: PM: direct-complete suspend driver flags: 0
[  420.314375] misc device-mapper: PM: direct-complete suspend driver flags: 0
[  420.314377] misc nvme-fabrics: PM: direct-complete suspend driver flags: 0
[  420.314381] nvme-fabrics ctl: PM: direct-complete suspend driver flags: 0
[  420.314383] misc autofs: PM: direct-complete suspend driver flags: 0
[  420.314385] bdi btrfs-1: PM: direct-complete suspend driver flags: 0
[  420.314387] block sda2: PM: direct-complete suspend driver flags: 0
[  420.314389] block sda1: PM: direct-complete suspend driver flags: 0
[  420.314391] bdi 8:0: PM: direct-complete suspend driver flags: 0
[  420.314393] block sda: PM: direct-complete suspend driver flags: 0
[  420.314395] scsi_disk 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  420.314398] bsg 0:0:0:0: PM: direct-complete suspend driver flags: 0
[  420.314405] sd 0:0:0:0: PM: bus suspend driver flags: 0
[  420.314405] misc btrfs-control: PM: direct-complete suspend driver flags: 0
[  420.314409] workqueue scsi_tmf_0: PM: direct-complete suspend driver flags: 0
[  420.314413] vtconsole vtcon1: PM: direct-complete suspend driver flags: 0
[  420.314416] graphics fb0: PM: direct-complete suspend driver flags: 0
[  420.314420] drm_dp_aux_dev drm_dp_aux1: PM: direct-complete suspend driver flags: 0
[  420.314425] drm card0-DP-1: PM: direct-complete suspend driver flags: 0
[  420.314429] drm card0-HDMI-A-1: PM: direct-complete suspend driver flags: 0
[  420.314431] drm_dp_aux_dev drm_dp_aux0: PM: direct-complete suspend driver flags: 0
[  420.314433] backlight amdgpu_bl0: PM: class suspend driver flags: 0
[  420.314446] drm renderD128: PM: direct-complete suspend driver flags: 0
[  420.314449] hwmon hwmon2: PM: direct-complete suspend driver flags: 0
[  420.314455] kfd kfd: PM: direct-complete suspend driver flags: 0
[  420.314459] hidraw hidraw0: PM: direct-complete suspend driver flags: 0
[  420.314463] input mouse1: PM: direct-complete suspend driver flags: 0
[  420.314465] input input9: PM: type suspend driver flags: 0
[  420.314467] input mouse0: PM: direct-complete suspend driver flags: 0
[  420.314470] input input7: PM: type suspend driver flags: 0
[  420.314475] nvme-generic ng0n1: PM: direct-complete suspend driver flags: 0
[  420.314478] block nvme0n1p4: PM: direct-complete suspend driver flags: 0
[  420.314480] block nvme0n1p3: PM: direct-complete suspend driver flags: 0
[  420.314482] block nvme0n1p2: PM: direct-complete suspend driver flags: 0
[  420.314484] block nvme0n1p1: PM: direct-complete suspend driver flags: 0
[  420.314490] bdi 259:0: PM: direct-complete suspend driver flags: 0
[  420.314493] block nvme0n1: PM: direct-complete suspend driver flags: 0
[  420.314493] i2c_hid_acpi i2c-ELAN074E:00: PM: power domain suspend, may wakeup driver flags: 0
[  420.314496] hwmon hwmon1: PM: direct-complete suspend driver flags: 0
[  420.314498] nvme-subsystem nvme-subsys0: PM: direct-complete suspend driver flags: 0
[  420.314501] nvme nvme0: PM: direct-complete suspend driver flags: 0
[  420.314504] workqueue nvme-auth-wq: PM: direct-complete suspend driver flags: 0
[  420.314506] workqueue nvme-delete-wq: PM: direct-complete suspend driver flags: 0
[  420.314508] workqueue nvme-reset-wq: PM: direct-complete suspend driver flags: 0
[  420.314509] nvme 0000:02:00.0: PM: bus suspend driver flags: 0
[  420.314510] workqueue nvme-wq: PM: direct-complete suspend driver flags: 0
[  420.314512] input input3: PM: type suspend driver flags: 0
[  420.314515] thermal cooling_device16: PM: direct-complete suspend driver flags: 0
[  420.314518] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-4: PM: direct-complete suspend driver flags: 0
[  420.314520] wmi ABBC0F6A-8EA1-11D1-00A0-C90629100000: PM: direct-complete suspend driver flags: 0
[  420.314522] input input2: PM: type suspend driver flags: 0
[  420.314525] wmi_bus wmi_bus-PNP0C14:04: PM: direct-complete suspend driver flags: 0
[  420.314527] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-3: PM: direct-complete suspend driver flags: 0
[  420.314529] wmi 40D1BF71-A82D-4E59-A168-3985E03B2E87: PM: direct-complete suspend driver flags: 0
[  420.314532] wmi 431F16ED-0C2B-444C-B267-27DEB140CF9C: PM: direct-complete suspend driver flags: 0
[  420.314534] wmi 67C3371D-95A3-4C37-BB61-DD47B491DAAB: PM: direct-complete suspend driver flags: 0
[  420.314536] wmi D9F41781-F633-4400-9355-601770BEC510: PM: direct-complete suspend driver flags: 0
[  420.314540] wmi_bus wmi_bus-PNP0C14:03: PM: direct-complete suspend driver flags: 0
[  420.314543] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-2: PM: direct-complete suspend driver flags: 0
[  420.314545] wmi 1F13AB7F-6220-4210-8F8E-8BB5E71EE969: PM: direct-complete suspend driver flags: 0
[  420.314547] input input1: PM: type suspend driver flags: 0
[  420.314550] wmi_bus wmi_bus-PNP0C14:02: PM: direct-complete suspend driver flags: 0
[  420.314552] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910-1: PM: direct-complete suspend driver flags: 0
[  420.314554] wmi A6FEA33E-DABF-46F5-BFC8-460D961BEC9F: PM: direct-complete suspend driver flags: 0
[  420.314556] wmi 2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B: PM: direct-complete suspend driver flags: 0
[  420.314558] wmi_bus wmi_bus-PNP0C14:01: PM: direct-complete suspend driver flags: 0
[  420.314561] wmi 8232DE3D-663D-4327-A8F4-E293ADB9BF05: PM: direct-complete suspend driver flags: 0
[  420.314562] wmi 322F2028-0F84-4901-988E-015176049E2D: PM: direct-complete suspend driver flags: 0
[  420.314564] wmi 14EA9746-CE1F-4098-A0E0-7045CB4DA745: PM: direct-complete suspend driver flags: 0
[  420.314566] wmi 988D08E3-68F4-4C35-AF3E-6A1B8106F83C: PM: direct-complete suspend driver flags: 0
[  420.314568] wmi 2D114B49-2DFB-4130-B8FE-4A3C09E75133: PM: direct-complete suspend driver flags: 0
[  420.314570] wmi 1F4C91EB-DC5C-460B-951D-C7CB9B4B8D5E: PM: direct-complete suspend driver flags: 0
[  420.314572] wmi-bmof 05901221-D566-11D1-B2F0-00A0C9062910: PM: direct-complete suspend driver flags: 0
[  420.314574] wmi 2B814318-4BE8-4707-9D84-A190A859B5D0: PM: direct-complete suspend driver flags: 0
[  420.314576] wmi 95F24279-4D7B-4334-9387-ACCDC67EF61C: PM: direct-complete suspend driver flags: 0
[  420.314578] wmi 5FB7F034-2C63-45E9-BE91-3D44E2C707E4: PM: direct-complete suspend driver flags: 0
[  420.314582] wmi_bus wmi_bus-PNP0C14:00: PM: direct-complete suspend driver flags: 0
[  420.314584] memory_tiering memory_tier4: PM: direct-complete suspend driver flags: 0
[  420.314586] misc cpu_dma_latency: PM: direct-complete suspend driver flags: 0
[  420.314588] platform microcode: PM: bus suspend driver flags: 0
[  420.314591] machinecheck machinecheck15: PM: direct-complete suspend driver flags: 0
[  420.314592] machinecheck machinecheck14: PM: direct-complete suspend driver flags: 0
[  420.314594] machinecheck machinecheck13: PM: direct-complete suspend driver flags: 0
[  420.314596] machinecheck machinecheck12: PM: direct-complete suspend driver flags: 0
[  420.314598] machinecheck machinecheck11: PM: direct-complete suspend driver flags: 0
[  420.314600] machinecheck machinecheck10: PM: direct-complete suspend driver flags: 0
[  420.314602] machinecheck machinecheck9: PM: direct-complete suspend driver flags: 0
[  420.314604] machinecheck machinecheck8: PM: direct-complete suspend driver flags: 0
[  420.314606] machinecheck machinecheck7: PM: direct-complete suspend driver flags: 0
[  420.314607] machinecheck machinecheck6: PM: direct-complete suspend driver flags: 0
[  420.314609] machinecheck machinecheck5: PM: direct-complete suspend driver flags: 0
[  420.314611] machinecheck machinecheck4: PM: direct-complete suspend driver flags: 0
[  420.314613] machinecheck machinecheck3: PM: direct-complete suspend driver flags: 0
[  420.314615] machinecheck machinecheck2: PM: direct-complete suspend driver flags: 0
[  420.314617] machinecheck machinecheck1: PM: direct-complete suspend driver flags: 0
[  420.314618] machinecheck machinecheck0: PM: direct-complete suspend driver flags: 0
[  420.314620]  machinecheck: PM: direct-complete suspend driver flags: 0
[  420.314622] leds input0::scrolllock: PM: class suspend driver flags: 0
[  420.314624] leds input0::capslock: PM: class suspend driver flags: 0
[  420.314627] leds input0::numlock: PM: class suspend driver flags: 0
[  420.314630] input input0: PM: type suspend driver flags: 0
[  420.314632] nvmem cmos_nvram0: PM: direct-complete suspend driver flags: 0
[  420.314635] alarmtimer alarmtimer.0.auto: PM: bus suspend, may wakeup driver flags: 0
[  420.314639] rtc rtc0: PM: class suspend driver flags: 0
[  420.314641] misc psaux: PM: direct-complete suspend driver flags: 0
[  420.314644] atkbd serio0: PM: bus suspend, may wakeup driver flags: 0
[  420.316250] i2c_designware AMDI0010:03: PM: power domain suspend driver flags: 6
[  420.318027] input mice: PM: direct-complete suspend driver flags: 0
[  420.318031] i8042 i8042: PM: bus suspend driver flags: 0
[  420.318045] misc udmabuf: PM: direct-complete suspend driver flags: 0
[  420.318049] dma_heap system: PM: direct-complete suspend driver flags: 0
[  420.318053] tpmrm tpmrm0: PM: direct-complete suspend driver flags: 0
[  420.318057] tpm tpm0: PM: direct-complete suspend driver flags: 0
[  420.318060] misc hpet: PM: direct-complete suspend driver flags: 0
[  420.318064] tty ttyS3: PM: direct-complete suspend driver flags: 0
[  420.318068] port serial8250:0.3: PM: driver suspend driver flags: 0
[  420.318073] tty ttyS2: PM: direct-complete suspend driver flags: 0
[  420.318077] port serial8250:0.2: PM: driver suspend driver flags: 0
[  420.318081] tty ttyS1: PM: direct-complete suspend driver flags: 0
[  420.318085] port serial8250:0.1: PM: driver suspend driver flags: 0
[  420.318089] tty ttyS0: PM: direct-complete suspend driver flags: 0
[  420.318093] port serial8250:0.0: PM: driver suspend driver flags: 0
[  420.318101] serial8250 serial8250: PM: bus suspend driver flags: 0
[  420.318106] tty ptmx: PM: direct-complete suspend driver flags: 0
[  420.318110] thermal thermal_zone1: PM: direct-complete suspend driver flags: 0
[  420.318113] hwmon hwmon0: PM: direct-complete suspend driver flags: 0
[  420.318117] thermal thermal_zone0: PM: direct-complete suspend driver flags: 0
[  420.318120] thermal cooling_device15: PM: direct-complete suspend driver flags: 0
[  420.318124] thermal cooling_device14: PM: direct-complete suspend driver flags: 0
[  420.318127] thermal cooling_device13: PM: direct-complete suspend driver flags: 0
[  420.318130] thermal cooling_device12: PM: direct-complete suspend driver flags: 0
[  420.318134] thermal cooling_device11: PM: direct-complete suspend driver flags: 0
[  420.318137] thermal cooling_device10: PM: direct-complete suspend driver flags: 0
[  420.318140] thermal cooling_device9: PM: direct-complete suspend driver flags: 0
[  420.318144] thermal cooling_device8: PM: direct-complete suspend driver flags: 0
[  420.318147] thermal cooling_device7: PM: direct-complete suspend driver flags: 0
[  420.318150] thermal cooling_device6: PM: direct-complete suspend driver flags: 0
[  420.318154] thermal cooling_device5: PM: direct-complete suspend driver flags: 0
[  420.318157] thermal cooling_device4: PM: direct-complete suspend driver flags: 0
[  420.318160] thermal cooling_device3: PM: direct-complete suspend driver flags: 0
[  420.318163] thermal cooling_device2: PM: direct-complete suspend driver flags: 0
[  420.318166] thermal cooling_device1: PM: direct-complete suspend driver flags: 0
[  420.318170] thermal cooling_device0: PM: direct-complete suspend driver flags: 0
[  420.318174] gpio gpiochip512: PM: direct-complete suspend driver flags: 0
[  420.318178] gpio gpiochip0: PM: direct-complete suspend driver flags: 0
[  420.318182] misc fuse: PM: direct-complete suspend driver flags: 0
[  420.318185] misc userfaultfd: PM: direct-complete suspend driver flags: 0
[  420.318189] event_source software: PM: direct-complete suspend driver flags: 0
[  420.318192] event_source tracepoint: PM: direct-complete suspend driver flags: 0
[  420.318196] event_source kprobe: PM: direct-complete suspend driver flags: 0
[  420.318199] event_source uprobe: PM: direct-complete suspend driver flags: 0
[  420.318203] event_source breakpoint: PM: direct-complete suspend driver flags: 0
[  420.318206] event_source cpu: PM: direct-complete suspend driver flags: 0
[  420.318209] event_source ibs_fetch: PM: direct-complete suspend driver flags: 0
[  420.318213] event_source ibs_op: PM: direct-complete suspend driver flags: 0
[  420.318216] event_source amd_df: PM: direct-complete suspend driver flags: 0
[  420.318219] event_source amd_l3: PM: direct-complete suspend driver flags: 0
[  420.318223] event_source amd_iommu_0: PM: direct-complete suspend driver flags: 0
[  420.318226] event_source msr: PM: direct-complete suspend driver flags: 0
[  420.318230] clockevents broadcast: PM: direct-complete suspend driver flags: 0
[  420.318233] clockevents clockevent15: PM: direct-complete suspend driver flags: 0
[  420.318237] clockevents clockevent14: PM: direct-complete suspend driver flags: 0
[  420.318240] clockevents clockevent13: PM: direct-complete suspend driver flags: 0
[  420.318243] clockevents clockevent12: PM: direct-complete suspend driver flags: 0
[  420.318247] clockevents clockevent11: PM: direct-complete suspend driver flags: 0
[  420.318250] clockevents clockevent10: PM: direct-complete suspend driver flags: 0
[  420.318253] clockevents clockevent9: PM: direct-complete suspend driver flags: 0
[  420.318257] clockevents clockevent8: PM: direct-complete suspend driver flags: 0
[  420.318260] clockevents clockevent7: PM: direct-complete suspend driver flags: 0
[  420.318263] clockevents clockevent6: PM: direct-complete suspend driver flags: 0
[  420.318267] clockevents clockevent5: PM: direct-complete suspend driver flags: 0
[  420.318270] clockevents clockevent4: PM: direct-complete suspend driver flags: 0
[  420.318273] clockevents clockevent3: PM: direct-complete suspend driver flags: 0
[  420.318276] clockevents clockevent2: PM: direct-complete suspend driver flags: 0
[  420.318280] clockevents clockevent1: PM: direct-complete suspend driver flags: 0
[  420.318283] clockevents clockevent0: PM: direct-complete suspend driver flags: 0
[  420.318286]  clockevents: PM: direct-complete suspend driver flags: 0
[  420.318289] clocksource clocksource0: PM: direct-complete suspend driver flags: 0
[  420.318293]  clocksource: PM: direct-complete suspend driver flags: 0
[  420.318296] misc snapshot: PM: direct-complete suspend driver flags: 0
[  420.318300] pcspkr pcspkr: PM: bus suspend driver flags: 0
[  420.318313] iommu ivhd0: PM: direct-complete suspend driver flags: 0
[  420.318320] misc hw_random: PM: direct-complete suspend driver flags: 0
[  420.318323] tty tty63: PM: direct-complete suspend driver flags: 0
[  420.318327] tty tty62: PM: direct-complete suspend driver flags: 0
[  420.318327] pci 0000:00:00.2: PM: bus suspend driver flags: 0
[  420.318330] tty tty61: PM: direct-complete suspend driver flags: 0
[  420.318334] tty tty60: PM: direct-complete suspend driver flags: 0
[  420.318337] tty tty59: PM: direct-complete suspend driver flags: 0
[  420.318340] tty tty58: PM: direct-complete suspend driver flags: 0
[  420.318344] tty tty57: PM: direct-complete suspend driver flags: 0
[  420.318347] tty tty56: PM: direct-complete suspend driver flags: 0
[  420.318350] tty tty55: PM: direct-complete suspend driver flags: 0
[  420.318353] tty tty54: PM: direct-complete suspend driver flags: 0
[  420.318357] tty tty53: PM: direct-complete suspend driver flags: 0
[  420.318360] tty tty52: PM: direct-complete suspend driver flags: 0
[  420.318363] tty tty51: PM: direct-complete suspend driver flags: 0
[  420.318366] tty tty50: PM: direct-complete suspend driver flags: 0
[  420.318370] tty tty49: PM: direct-complete suspend driver flags: 0
[  420.318373] tty tty48: PM: direct-complete suspend driver flags: 0
[  420.318376] tty tty47: PM: direct-complete suspend driver flags: 0
[  420.318379] tty tty46: PM: direct-complete suspend driver flags: 0
[  420.318383] tty tty45: PM: direct-complete suspend driver flags: 0
[  420.318386] tty tty44: PM: direct-complete suspend driver flags: 0
[  420.318389] tty tty43: PM: direct-complete suspend driver flags: 0
[  420.318392] tty tty42: PM: direct-complete suspend driver flags: 0
[  420.318395] tty tty41: PM: direct-complete suspend driver flags: 0
[  420.318399] tty tty40: PM: direct-complete suspend driver flags: 0
[  420.318402] tty tty39: PM: direct-complete suspend driver flags: 0
[  420.318405] tty tty38: PM: direct-complete suspend driver flags: 0
[  420.318409] tty tty37: PM: direct-complete suspend driver flags: 0
[  420.318412] tty tty36: PM: direct-complete suspend driver flags: 0
[  420.318415] tty tty35: PM: direct-complete suspend driver flags: 0
[  420.318418] tty tty34: PM: direct-complete suspend driver flags: 0
[  420.318422] tty tty33: PM: direct-complete suspend driver flags: 0
[  420.318425] tty tty32: PM: direct-complete suspend driver flags: 0
[  420.318428] tty tty31: PM: direct-complete suspend driver flags: 0
[  420.318431] tty tty30: PM: direct-complete suspend driver flags: 0
[  420.318435] tty tty29: PM: direct-complete suspend driver flags: 0
[  420.318438] tty tty28: PM: direct-complete suspend driver flags: 0
[  420.318441] tty tty27: PM: direct-complete suspend driver flags: 0
[  420.318444] tty tty26: PM: direct-complete suspend driver flags: 0
[  420.318448] tty tty25: PM: direct-complete suspend driver flags: 0
[  420.318451] tty tty24: PM: direct-complete suspend driver flags: 0
[  420.318454] tty tty23: PM: direct-complete suspend driver flags: 0
[  420.318457] tty tty22: PM: direct-complete suspend driver flags: 0
[  420.318460] tty tty21: PM: direct-complete suspend driver flags: 0
[  420.318464] tty tty20: PM: direct-complete suspend driver flags: 0
[  420.318467] tty tty19: PM: direct-complete suspend driver flags: 0
[  420.318470] tty tty18: PM: direct-complete suspend driver flags: 0
[  420.318473] tty tty17: PM: direct-complete suspend driver flags: 0
[  420.318477] tty tty16: PM: direct-complete suspend driver flags: 0
[  420.318480] tty tty15: PM: direct-complete suspend driver flags: 0
[  420.318483] tty tty14: PM: direct-complete suspend driver flags: 0
[  420.318486] tty tty13: PM: direct-complete suspend driver flags: 0
[  420.318489] tty tty12: PM: direct-complete suspend driver flags: 0
[  420.318493] tty tty11: PM: direct-complete suspend driver flags: 0
[  420.318496] tty tty10: PM: direct-complete suspend driver flags: 0
[  420.318499] tty tty9: PM: direct-complete suspend driver flags: 0
[  420.318503] tty tty8: PM: direct-complete suspend driver flags: 0
[  420.318506] tty tty7: PM: direct-complete suspend driver flags: 0
[  420.318509] tty tty6: PM: direct-complete suspend driver flags: 0
[  420.318512] tty tty5: PM: direct-complete suspend driver flags: 0
[  420.318516] tty tty4: PM: direct-complete suspend driver flags: 0
[  420.318519] tty tty3: PM: direct-complete suspend driver flags: 0
[  420.318522] tty tty2: PM: direct-complete suspend driver flags: 0
[  420.318525] tty tty1: PM: direct-complete suspend driver flags: 0
[  420.318528] vc vcsa1: PM: direct-complete suspend driver flags: 0
[  420.318532] vc vcsu1: PM: direct-complete suspend driver flags: 0
[  420.318535] vc vcs1: PM: direct-complete suspend driver flags: 0
[  420.318538] vc vcsa: PM: direct-complete suspend driver flags: 0
[  420.318544] vc vcsu: PM: direct-complete suspend driver flags: 0
[  420.318549] vc vcs: PM: direct-complete suspend driver flags: 0
[  420.318553] tty tty0: PM: direct-complete suspend driver flags: 0
[  420.318557] tty console: PM: direct-complete suspend driver flags: 0
[  420.318562] tty tty: PM: direct-complete suspend driver flags: 0
[  420.318567] mem kmsg: PM: direct-complete suspend driver flags: 0
[  420.318570] mem urandom: PM: direct-complete suspend driver flags: 0
[  420.318573] mem random: PM: direct-complete suspend driver flags: 0
[  420.318577] mem full: PM: direct-complete suspend driver flags: 0
[  420.318580] mem zero: PM: direct-complete suspend driver flags: 0
[  420.318583] mem port: PM: direct-complete suspend driver flags: 0
[  420.318587] mem null: PM: direct-complete suspend driver flags: 0
[  420.318590] mem mem: PM: direct-complete suspend driver flags: 0
[  420.318593] system 00:03: PM: bus suspend driver flags: 0
[  420.318598] i8042 kbd 00:02: PM: bus suspend driver flags: 0
[  420.318603] rtc_cmos 00:01: PM: bus suspend, may wakeup driver flags: 0
[  420.318634] system 00:00: PM: bus suspend driver flags: 0
[  420.318641] misc vga_arbiter: PM: direct-complete suspend driver flags: 0
[  420.318645] net lo: PM: direct-complete suspend driver flags: 0
[  420.318648] platform efivars.0: PM: bus suspend driver flags: 0
[  420.318653] platform rtc-efi.0: PM: bus suspend driver flags: 0
[  420.318657] edac mc: PM: direct-complete suspend driver flags: 0
[  420.318660]  edac: PM: direct-complete suspend driver flags: 0
[  420.318665] acpi ELAN074E:00: PM: direct-complete suspend driver flags: 0
[  420.318669] acpi-wmi PNP0C14:04: PM: power domain suspend driver flags: 0
[  420.318674] platform PNP0103:00: PM: bus suspend driver flags: 0
[  420.318678] acpi-fan PNP0C0B:00: PM: bus suspend driver flags: 0
[  420.318683] amd_pmc AMDI0005:00: PM: power domain suspend driver flags: 0
[  420.318689] ucsi_acpi USBC000:00: PM: power domain suspend driver flags: 0
[  420.318693] platform ACPI000E:00: PM: bus suspend driver flags: 0
[  420.318698] acpi-wmi PNP0C14:03: PM: power domain suspend driver flags: 0
[  420.318702] platform PNP0C0D:00: PM: bus suspend driver flags: 0
[  420.318707] acpi-wmi PNP0C14:02: PM: power domain suspend driver flags: 0
[  420.318712] acpi-wmi PNP0C14:01: PM: power domain suspend driver flags: 0
[  420.318717] acpi-wmi PNP0C14:00: PM: power domain suspend driver flags: 0
[  420.318722] platform MSFT0101:00: PM: bus suspend driver flags: 0
[  420.318726] amd_gpio AMDI0030:00: PM: power domain suspend driver flags: 0
[  420.318731] platform acpi-cpufreq: PM: bus suspend driver flags: 0
[  420.318735] platform PNP0C0C:00: PM: bus suspend driver flags: 0
[  420.318739] platform HPIC0003:00: PM: bus suspend driver flags: 0
[  420.318743] platform PNP0C0A:00: PM: bus suspend driver flags: 0
[  420.318747] ac ACPI0003:00: PM: power domain suspend driver flags: 0
[  420.318752] platform PNP0C09:00: PM: bus suspend driver flags: 0
[  420.318759] platform PNP0800:00: PM: bus suspend driver flags: 0
[  420.318765] pci 0000:00:14.3: PM: bus suspend driver flags: 0
[  420.318769] pci_bus 0000:03: PM: direct-complete suspend driver flags: 0
[  420.318778] pci_bus 0000:02: PM: direct-complete suspend driver flags: 0
[  420.318783] pci_bus 0000:01: PM: direct-complete suspend driver flags: 0
[  420.318792] pci_bus 0000:00: PM: direct-complete suspend driver flags: 0
[  420.318796] acpi PNP0C14:04: PM: direct-complete suspend driver flags: 0
[  420.318800] acpi PNP0103:00: PM: direct-complete suspend driver flags: 0
[  420.318804] thermal LNXTHERM:01: PM: driver suspend driver flags: 0
[  420.318818] thermal LNXTHERM:00: PM: driver suspend driver flags: 0
[  420.318826] acpi PNP0C0B:00: PM: direct-complete suspend driver flags: 0
[  420.318830] acpi LNXPOWER:09: PM: direct-complete suspend driver flags: 0
[  420.318840] acpi AMDI0005:00: PM: direct-complete suspend driver flags: 0
[  420.318846] acpi device:3f: PM: direct-complete suspend driver flags: 0
[  420.318850] acpi USBC000:00: PM: direct-complete suspend driver flags: 0
[  420.318854] acpi ACPI000C:00: PM: direct-complete suspend driver flags: 0
[  420.318857] acpi ACPI000E:00: PM: direct-complete suspend driver flags: 0
[  420.318861] acpi PNP0C02:0d: PM: direct-complete suspend driver flags: 0
[  420.318864] acpi PNP0C02:0c: PM: direct-complete suspend driver flags: 0
[  420.318868] acpi PNP0C02:0b: PM: direct-complete suspend driver flags: 0
[  420.318871] acpi PNP0C02:0a: PM: direct-complete suspend driver flags: 0
[  420.318875] acpi PNP0C02:09: PM: direct-complete suspend driver flags: 0
[  420.318878] acpi PNP0C02:08: PM: direct-complete suspend driver flags: 0
[  420.318882] acpi PNP0C02:07: PM: direct-complete suspend driver flags: 0
[  420.318885] acpi PNP0C02:06: PM: direct-complete suspend driver flags: 0
[  420.318889] acpi PNP0C02:05: PM: direct-complete suspend driver flags: 0
[  420.318892] acpi PNP0C02:04: PM: direct-complete suspend driver flags: 0
[  420.318898] acpi PNP0C02:03: PM: direct-complete suspend driver flags: 0
[  420.318901] acpi LNXPOWER:08: PM: direct-complete suspend driver flags: 0
[  420.318905] acpi LNXPOWER:07: PM: direct-complete suspend driver flags: 0
[  420.318908] acpi HPQ6007:00: PM: direct-complete suspend driver flags: 0
[  420.318912] acpi HPQ6001:00: PM: direct-complete suspend driver flags: 0
[  420.318916] acpi PNP0C14:03: PM: direct-complete suspend driver flags: 0
[  420.318919] acpi PNP0C0E:00: PM: direct-complete suspend driver flags: 0
[  420.318923] button PNP0C0D:00: PM: driver suspend, may wakeup driver flags: 0
[  420.318929] acpi PNP0C14:02: PM: direct-complete suspend driver flags: 0
[  420.318933] acpi PNP0C14:01: PM: direct-complete suspend driver flags: 0
[  420.318936] acpi PNP0C14:00: PM: direct-complete suspend driver flags: 0
[  420.318940] tpm_crb MSFT0101:00: PM: driver suspend driver flags: 0
[  420.320248] acpi AMDI0040:00: PM: direct-complete suspend driver flags: 0
[  420.320256] acpi AMDI0010:05: PM: direct-complete suspend driver flags: 0
[  420.320259] acpi AMDI0010:04: PM: direct-complete suspend driver flags: 0
[  420.320262] acpi AMDI0010:03: PM: direct-complete suspend driver flags: 0
[  420.320264] acpi AMDI0010:02: PM: direct-complete suspend driver flags: 0
[  420.320266] acpi AMDI0010:01: PM: direct-complete suspend driver flags: 0
[  420.320268] acpi AMDI0010:00: PM: direct-complete suspend driver flags: 0
[  420.320270] acpi AMDI0020:03: PM: direct-complete suspend driver flags: 0
[  420.320272] acpi AMDI0020:02: PM: direct-complete suspend driver flags: 0
[  420.320274] acpi AMDI0020:01: PM: direct-complete suspend driver flags: 0
[  420.320276] acpi AMDI0020:00: PM: direct-complete suspend driver flags: 0
[  420.320278] acpi AMDI0030:00: PM: direct-complete suspend driver flags: 0
[  420.320280] acpi AMDI0060:00: PM: direct-complete suspend driver flags: 0
[  420.320282] acpi PNP0C0F:07: PM: direct-complete suspend driver flags: 0
[  420.320284] acpi PNP0C0F:06: PM: direct-complete suspend driver flags: 0
[  420.320286] acpi PNP0C0F:05: PM: direct-complete suspend driver flags: 0
[  420.320288] acpi PNP0C0F:04: PM: direct-complete suspend driver flags: 0
[  420.320290] acpi PNP0C0F:03: PM: direct-complete suspend driver flags: 0
[  420.320292] acpi PNP0C0F:02: PM: direct-complete suspend driver flags: 0
[  420.320294] acpi PNP0C0F:01: PM: direct-complete suspend driver flags: 0
[  420.320296] acpi PNP0C0F:00: PM: direct-complete suspend driver flags: 0
[  420.320298] acpi ACPI0007:0f: PM: direct-complete suspend driver flags: 0
[  420.320300] acpi ACPI0007:0e: PM: direct-complete suspend driver flags: 0
[  420.320302] acpi ACPI0007:0d: PM: direct-complete suspend driver flags: 0
[  420.320304] acpi ACPI0007:0c: PM: direct-complete suspend driver flags: 0
[  420.320306] acpi ACPI0007:0b: PM: direct-complete suspend driver flags: 0
[  420.320308] acpi ACPI0007:0a: PM: direct-complete suspend driver flags: 0
[  420.320310] acpi ACPI0007:09: PM: direct-complete suspend driver flags: 0
[  420.320312] acpi ACPI0007:08: PM: direct-complete suspend driver flags: 0
[  420.320314] acpi ACPI0007:07: PM: direct-complete suspend driver flags: 0
[  420.320316] acpi ACPI0007:06: PM: direct-complete suspend driver flags: 0
[  420.320318] acpi ACPI0007:05: PM: direct-complete suspend driver flags: 0
[  420.320320] acpi ACPI0007:04: PM: direct-complete suspend driver flags: 0
[  420.320322] acpi ACPI0007:03: PM: direct-complete suspend driver flags: 0
[  420.320324] acpi ACPI0007:02: PM: direct-complete suspend driver flags: 0
[  420.320326] acpi ACPI0007:01: PM: direct-complete suspend driver flags: 0
[  420.320328] acpi ACPI0007:00: PM: direct-complete suspend driver flags: 0
[  420.320333] acpi ACPI0010:00: PM: direct-complete suspend driver flags: 0
[  420.320335] button PNP0C0C:00: PM: driver suspend, may wakeup driver flags: 0
[  420.320338] acpi device:3e: PM: direct-complete suspend driver flags: 0
[  420.320340] acpi device:3d: PM: direct-complete suspend driver flags: 0
[  420.320343] acpi device:3c: PM: direct-complete suspend driver flags: 0
[  420.320345] acpi device:3b: PM: direct-complete suspend driver flags: 0
[  420.320347] acpi device:3a: PM: direct-complete suspend driver flags: 0
[  420.320349] acpi device:39: PM: direct-complete suspend driver flags: 0
[  420.320351] acpi device:38: PM: direct-complete suspend driver flags: 0
[  420.320354] acpi device:37: PM: direct-complete suspend driver flags: 0
[  420.320356] acpi device:36: PM: direct-complete suspend driver flags: 0
[  420.320358] acpi device:35: PM: direct-complete suspend driver flags: 0
[  420.320360] acpi device:34: PM: direct-complete suspend driver flags: 0
[  420.320362] acpi HPIC0003:00: PM: direct-complete suspend driver flags: 0
[  420.320364] acpi PNP0500:03: PM: direct-complete suspend driver flags: 0
[  420.320366] acpi PNP0500:02: PM: direct-complete suspend driver flags: 0
[  420.320368] acpi PNP0500:01: PM: direct-complete suspend driver flags: 0
[  420.320370] acpi PNP0500:00: PM: direct-complete suspend driver flags: 0
[  420.320372] acpi device:33: PM: direct-complete suspend driver flags: 0
[  420.320374] acpi device:32: PM: direct-complete suspend driver flags: 0
[  420.320376] acpi device:31: PM: direct-complete suspend driver flags: 0
[  420.320378] acpi device:30: PM: direct-complete suspend driver flags: 0
[  420.320381] acpi device:2f: PM: direct-complete suspend driver flags: 0
[  420.320383] acpi LNXPOWER:06: PM: direct-complete suspend driver flags: 0
[  420.320384] acpi device:2e: PM: direct-complete suspend driver flags: 0
[  420.320387] acpi device:2d: PM: direct-complete suspend driver flags: 0
[  420.320389] acpi device:2c: PM: direct-complete suspend driver flags: 0
[  420.320391] acpi PNP0C02:02: PM: direct-complete suspend driver flags: 0
[  420.320393] acpi SYNA3290:00: PM: direct-complete suspend driver flags: 0
[  420.320395] acpi HPQ8001:00: PM: direct-complete suspend driver flags: 0
[  420.320399] acpi ACPI0003:00: PM: direct-complete suspend driver flags: 0
[  420.320402] ec PNP0C09:00: PM: driver suspend driver flags: 0
[  420.320404] acpi PNP0800:00: PM: direct-complete suspend driver flags: 0
[  420.320407] acpi PNP0B00:00: PM: direct-complete suspend driver flags: 0
[  420.320409] acpi PNP0100:00: PM: direct-complete suspend driver flags: 0
[  420.320410] acpi PNP0200:00: PM: direct-complete suspend driver flags: 0
[  420.320413] acpi PNP0000:00: PM: direct-complete suspend driver flags: 0
[  420.320418] acpi device:2a: PM: direct-complete suspend driver flags: 0
[  420.320420] acpi device:29: PM: direct-complete suspend driver flags: 0
[  420.320422] acpi device:28: PM: direct-complete suspend driver flags: 0
[  420.320424] acpi device:27: PM: direct-complete suspend driver flags: 0
[  420.320427] acpi device:26: PM: direct-complete suspend driver flags: 0
[  420.320429] acpi device:25: PM: direct-complete suspend driver flags: 0
[  420.320431] acpi LNXPOWER:05: PM: direct-complete suspend driver flags: 0
[  420.320433] acpi device:24: PM: direct-complete suspend driver flags: 0
[  420.320435] acpi LNXPOWER:04: PM: direct-complete suspend driver flags: 0
[  420.320438] acpi device:23: PM: direct-complete suspend driver flags: 0
[  420.320441] acpi device:22: PM: direct-complete suspend driver flags: 0
[  420.320445] acpi device:21: PM: direct-complete suspend driver flags: 0
[  420.320448] acpi device:20: PM: direct-complete suspend driver flags: 0
[  420.320452] acpi device:1f: PM: direct-complete suspend driver flags: 0
[  420.320456] acpi device:1e: PM: direct-complete suspend driver flags: 0
[  420.320461] acpi device:1d: PM: direct-complete suspend driver flags: 0
[  420.320465] acpi device:1c: PM: direct-complete suspend driver flags: 0
[  420.320471] acpi device:1b: PM: direct-complete suspend driver flags: 0
[  420.320476] acpi device:1a: PM: direct-complete suspend driver flags: 0
[  420.320480] acpi LNXPOWER:03: PM: direct-complete suspend driver flags: 0
[  420.320485] acpi LNXPOWER:02: PM: direct-complete suspend driver flags: 0
[  420.320489] acpi device:19: PM: direct-complete suspend driver flags: 0
[  420.320493] acpi device:18: PM: direct-complete suspend driver flags: 0
[  420.320498] acpi device:17: PM: direct-complete suspend driver flags: 0
[  420.320503] acpi device:16: PM: direct-complete suspend driver flags: 0
[  420.320507] acpi device:15: PM: direct-complete suspend driver flags: 0
[  420.320512] acpi device:14: PM: direct-complete suspend driver flags: 0
[  420.320516] acpi device:13: PM: direct-complete suspend driver flags: 0
[  420.320520] acpi device:12: PM: direct-complete suspend driver flags: 0
[  420.320526] acpi device:11: PM: direct-complete suspend driver flags: 0
[  420.320531] acpi device:10: PM: direct-complete suspend driver flags: 0
[  420.320536] acpi LNXPOWER:01: PM: direct-complete suspend driver flags: 0
[  420.320540] acpi LNXPOWER:00: PM: direct-complete suspend driver flags: 0
[  420.320545] acpi device:0f: PM: direct-complete suspend driver flags: 0
[  420.320551] acpi device:0e: PM: direct-complete suspend driver flags: 0
[  420.320557] acpi PNP0C02:01: PM: direct-complete suspend driver flags: 0
[  420.320563] acpi device:0d: PM: direct-complete suspend driver flags: 0
[  420.320568] acpi device:0c: PM: direct-complete suspend driver flags: 0
[  420.320572] acpi device:0b: PM: direct-complete suspend driver flags: 0
[  420.320588] acpi device:09: PM: direct-complete suspend driver flags: 0
[  420.320593] acpi device:08: PM: direct-complete suspend driver flags: 0
[  420.320597] acpi device:07: PM: direct-complete suspend driver flags: 0
[  420.320602] acpi device:06: PM: direct-complete suspend driver flags: 0
[  420.320606] acpi device:05: PM: direct-complete suspend driver flags: 0
[  420.320611] acpi device:04: PM: direct-complete suspend driver flags: 0
[  420.320615] acpi device:03: PM: direct-complete suspend driver flags: 0
[  420.320619] acpi device:02: PM: direct-complete suspend driver flags: 0
[  420.320624] acpi device:01: PM: direct-complete suspend driver flags: 0
[  420.320629] acpi device:00: PM: direct-complete suspend driver flags: 0
[  420.320634] acpi PNP0C02:00: PM: direct-complete suspend driver flags: 0
[  420.320638] acpi PNP0C01:00: PM: direct-complete suspend driver flags: 0
[  420.320671] graphics fbcon: PM: direct-complete suspend driver flags: 0
[  420.320676] workqueue blkcg_punt_bio: PM: direct-complete suspend driver flags: 0
[  420.320680]  memory_tiering: PM: direct-complete suspend driver flags: 0
[  420.320684] workqueue writeback: PM: direct-complete suspend driver flags: 0
[  420.320689] dmi id: PM: direct-complete suspend driver flags: 0
[  420.320694] vtconsole vtcon0: PM: direct-complete suspend driver flags: 0
[  420.320698] regulator regulator.0: PM: class suspend driver flags: 0
[  420.320707]  workqueue: PM: direct-complete suspend driver flags: 0
[  420.320711]  container: PM: direct-complete suspend driver flags: 0
[  420.320716] processor cpu15: PM: direct-complete suspend driver flags: 0
[  420.320721] processor cpu14: PM: direct-complete suspend driver flags: 0
[  420.320726] processor cpu13: PM: direct-complete suspend driver flags: 0
[  420.320730] processor cpu12: PM: direct-complete suspend driver flags: 0
[  420.320735] processor cpu11: PM: direct-complete suspend driver flags: 0
[  420.320739] processor cpu10: PM: direct-complete suspend driver flags: 0
[  420.320744] processor cpu9: PM: direct-complete suspend driver flags: 0
[  420.320748] processor cpu8: PM: direct-complete suspend driver flags: 0
[  420.320753] processor cpu7: PM: direct-complete suspend driver flags: 0
[  420.320757] processor cpu6: PM: direct-complete suspend driver flags: 0
[  420.320762] processor cpu5: PM: direct-complete suspend driver flags: 0
[  420.320766] processor cpu4: PM: direct-complete suspend driver flags: 0
[  420.320771] processor cpu3: PM: direct-complete suspend driver flags: 0
[  420.320775] processor cpu2: PM: direct-complete suspend driver flags: 0
[  420.320780] processor cpu1: PM: direct-complete suspend driver flags: 0
[  420.320784] processor cpu0: PM: direct-complete suspend driver flags: 0
[  420.320788]  cpu: PM: direct-complete suspend driver flags: 0
[  420.320793] node node0: PM: direct-complete suspend driver flags: 0
[  420.320797]  node: PM: direct-complete suspend driver flags: 0
[  420.320802] memory memory131: PM: direct-complete suspend driver flags: 0
[  420.320806] memory memory130: PM: direct-complete suspend driver flags: 0
[  420.320810] memory memory129: PM: direct-complete suspend driver flags: 0
[  420.320814] memory memory128: PM: direct-complete suspend driver flags: 0
[  420.320818] memory memory127: PM: direct-complete suspend driver flags: 0
[  420.320822] memory memory126: PM: direct-complete suspend driver flags: 0
[  420.320826] memory memory125: PM: direct-complete suspend driver flags: 0
[  420.320831] memory memory124: PM: direct-complete suspend driver flags: 0
[  420.320835] memory memory123: PM: direct-complete suspend driver flags: 0
[  420.320839] memory memory122: PM: direct-complete suspend driver flags: 0
[  420.320843] memory memory121: PM: direct-complete suspend driver flags: 0
[  420.320847] memory memory120: PM: direct-complete suspend driver flags: 0
[  420.320851] memory memory119: PM: direct-complete suspend driver flags: 0
[  420.320855] memory memory118: PM: direct-complete suspend driver flags: 0
[  420.320859] memory memory117: PM: direct-complete suspend driver flags: 0
[  420.320863] memory memory116: PM: direct-complete suspend driver flags: 0
[  420.320867] memory memory115: PM: direct-complete suspend driver flags: 0
[  420.320872] memory memory114: PM: direct-complete suspend driver flags: 0
[  420.320876] memory memory113: PM: direct-complete suspend driver flags: 0
[  420.320880] memory memory112: PM: direct-complete suspend driver flags: 0
[  420.320884] memory memory111: PM: direct-complete suspend driver flags: 0
[  420.320888] memory memory110: PM: direct-complete suspend driver flags: 0
[  420.320892] memory memory109: PM: direct-complete suspend driver flags: 0
[  420.320896] memory memory108: PM: direct-complete suspend driver flags: 0
[  420.320900] memory memory107: PM: direct-complete suspend driver flags: 0
[  420.320905] memory memory106: PM: direct-complete suspend driver flags: 0
[  420.320909] memory memory105: PM: direct-complete suspend driver flags: 0
[  420.320913] memory memory104: PM: direct-complete suspend driver flags: 0
[  420.320917] memory memory103: PM: direct-complete suspend driver flags: 0
[  420.320921] memory memory102: PM: direct-complete suspend driver flags: 0
[  420.320925] memory memory101: PM: direct-complete suspend driver flags: 0
[  420.320929] memory memory100: PM: direct-complete suspend driver flags: 0
[  420.320933] memory memory99: PM: direct-complete suspend driver flags: 0
[  420.320938] memory memory98: PM: direct-complete suspend driver flags: 0
[  420.320942] memory memory97: PM: direct-complete suspend driver flags: 0
[  420.320946] memory memory96: PM: direct-complete suspend driver flags: 0
[  420.320950] memory memory95: PM: direct-complete suspend driver flags: 0
[  420.320954] memory memory94: PM: direct-complete suspend driver flags: 0
[  420.320958] memory memory93: PM: direct-complete suspend driver flags: 0
[  420.320962] memory memory92: PM: direct-complete suspend driver flags: 0
[  420.320966] memory memory91: PM: direct-complete suspend driver flags: 0
[  420.320970] memory memory90: PM: direct-complete suspend driver flags: 0
[  420.320975] memory memory89: PM: direct-complete suspend driver flags: 0
[  420.320979] memory memory88: PM: direct-complete suspend driver flags: 0
[  420.320983] memory memory87: PM: direct-complete suspend driver flags: 0
[  420.320988] memory memory86: PM: direct-complete suspend driver flags: 0
[  420.320992] memory memory85: PM: direct-complete suspend driver flags: 0
[  420.320996] memory memory84: PM: direct-complete suspend driver flags: 0
[  420.321000] memory memory83: PM: direct-complete suspend driver flags: 0
[  420.321004] memory memory82: PM: direct-complete suspend driver flags: 0
[  420.321008] memory memory81: PM: direct-complete suspend driver flags: 0
[  420.321012] memory memory80: PM: direct-complete suspend driver flags: 0
[  420.321016] memory memory79: PM: direct-complete suspend driver flags: 0
[  420.321020] memory memory78: PM: direct-complete suspend driver flags: 0
[  420.321024] memory memory77: PM: direct-complete suspend driver flags: 0
[  420.321028] memory memory76: PM: direct-complete suspend driver flags: 0
[  420.321033] memory memory75: PM: direct-complete suspend driver flags: 0
[  420.321037] memory memory74: PM: direct-complete suspend driver flags: 0
[  420.321041] memory memory73: PM: direct-complete suspend driver flags: 0
[  420.321046] memory memory72: PM: direct-complete suspend driver flags: 0
[  420.321050] memory memory71: PM: direct-complete suspend driver flags: 0
[  420.321054] memory memory70: PM: direct-complete suspend driver flags: 0
[  420.321058] memory memory69: PM: direct-complete suspend driver flags: 0
[  420.321062] memory memory68: PM: direct-complete suspend driver flags: 0
[  420.321066] memory memory67: PM: direct-complete suspend driver flags: 0
[  420.321070] memory memory66: PM: direct-complete suspend driver flags: 0
[  420.321074] memory memory65: PM: direct-complete suspend driver flags: 0
[  420.321078] memory memory64: PM: direct-complete suspend driver flags: 0
[  420.321083] memory memory63: PM: direct-complete suspend driver flags: 0
[  420.321087] memory memory62: PM: direct-complete suspend driver flags: 0
[  420.321091] memory memory61: PM: direct-complete suspend driver flags: 0
[  420.321095] memory memory60: PM: direct-complete suspend driver flags: 0
[  420.321099] memory memory59: PM: direct-complete suspend driver flags: 0
[  420.321103] memory memory58: PM: direct-complete suspend driver flags: 0
[  420.321108] memory memory57: PM: direct-complete suspend driver flags: 0
[  420.321112] memory memory56: PM: direct-complete suspend driver flags: 0
[  420.321116] memory memory55: PM: direct-complete suspend driver flags: 0
[  420.321120] memory memory54: PM: direct-complete suspend driver flags: 0
[  420.321124] memory memory53: PM: direct-complete suspend driver flags: 0
[  420.321128] memory memory52: PM: direct-complete suspend driver flags: 0
[  420.321132] memory memory51: PM: direct-complete suspend driver flags: 0
[  420.321136] memory memory50: PM: direct-complete suspend driver flags: 0
[  420.321140] memory memory49: PM: direct-complete suspend driver flags: 0
[  420.321144] memory memory48: PM: direct-complete suspend driver flags: 0
[  420.321149] memory memory47: PM: direct-complete suspend driver flags: 0
[  420.321153] memory memory46: PM: direct-complete suspend driver flags: 0
[  420.321157] memory memory45: PM: direct-complete suspend driver flags: 0
[  420.321161] memory memory44: PM: direct-complete suspend driver flags: 0
[  420.321165] memory memory43: PM: direct-complete suspend driver flags: 0
[  420.321169] memory memory42: PM: direct-complete suspend driver flags: 0
[  420.321173] memory memory41: PM: direct-complete suspend driver flags: 0
[  420.321177] memory memory40: PM: direct-complete suspend driver flags: 0
[  420.321181] memory memory39: PM: direct-complete suspend driver flags: 0
[  420.321186] memory memory38: PM: direct-complete suspend driver flags: 0
[  420.321190] memory memory37: PM: direct-complete suspend driver flags: 0
[  420.321194] memory memory36: PM: direct-complete suspend driver flags: 0
[  420.321198] memory memory35: PM: direct-complete suspend driver flags: 0
[  420.321202] memory memory34: PM: direct-complete suspend driver flags: 0
[  420.321206] memory memory33: PM: direct-complete suspend driver flags: 0
[  420.321210] memory memory32: PM: direct-complete suspend driver flags: 0
[  420.321215] memory memory23: PM: direct-complete suspend driver flags: 0
[  420.321219] memory memory22: PM: direct-complete suspend driver flags: 0
[  420.321223] memory memory21: PM: direct-complete suspend driver flags: 0
[  420.321227] memory memory20: PM: direct-complete suspend driver flags: 0
[  420.321231] memory memory19: PM: direct-complete suspend driver flags: 0
[  420.321235] memory memory18: PM: direct-complete suspend driver flags: 0
[  420.321239] memory memory17: PM: direct-complete suspend driver flags: 0
[  420.321243] memory memory16: PM: direct-complete suspend driver flags: 0
[  420.321247] memory memory15: PM: direct-complete suspend driver flags: 0
[  420.321251] memory memory14: PM: direct-complete suspend driver flags: 0
[  420.321256] memory memory13: PM: direct-complete suspend driver flags: 0
[  420.321260] memory memory12: PM: direct-complete suspend driver flags: 0
[  420.321264] memory memory11: PM: direct-complete suspend driver flags: 0
[  420.321268] memory memory10: PM: direct-complete suspend driver flags: 0
[  420.321272] memory memory9: PM: direct-complete suspend driver flags: 0
[  420.321277] memory memory8: PM: direct-complete suspend driver flags: 0
[  420.321281] memory memory7: PM: direct-complete suspend driver flags: 0
[  420.321285] memory memory6: PM: direct-complete suspend driver flags: 0
[  420.321289] memory memory5: PM: direct-complete suspend driver flags: 0
[  420.321293] memory memory4: PM: direct-complete suspend driver flags: 0
[  420.321297] memory memory3: PM: direct-complete suspend driver flags: 0
[  420.321301] memory memory2: PM: direct-complete suspend driver flags: 0
[  420.321305] memory memory1: PM: direct-complete suspend driver flags: 0
[  420.321309] memory memory0: PM: direct-complete suspend driver flags: 0
[  420.321313]  memory: PM: direct-complete suspend driver flags: 0
[  420.328549] amdgpu 0000:03:00.0: PM: bus suspend driver flags: 0
[  420.329518] snd_hda_intel 0000:03:00.6: PM: bus suspend driver flags: 0
[  420.337079] iwlwifi 0000:01:00.0: PM: bus suspend driver flags: 0
[  420.337106] pcieport 0000:00:02.2: PM: bus suspend driver flags: 5
[  420.337643] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  420.340327] xhci_hcd 0000:03:00.3: PM: bus suspend, may wakeup driver flags: 0
[  420.341894] scsi target0:0:0: PM: bus suspend driver flags: 0
[  420.341926] scsi host0: PM: bus suspend driver flags: 0
[  420.341966] usb 4-1: PM: type suspend driver flags: 0
[  420.364494] usb usb4: PM: type suspend driver flags: 0
[  420.366238] pcieport 0000:00:02.4: PM: bus suspend driver flags: 5
[  420.423713] usb usb3: PM: type suspend driver flags: 0
[  420.434260] xhci_hcd 0000:03:00.4: PM: bus suspend, may wakeup driver flags: 0
[  420.434507] pcieport 0000:00:08.1: PM: bus suspend, may wakeup driver flags: 5
[  420.434678] PM: suspend of devices complete after 121.663 msecs
[  420.434689] PM: start suspend of devices complete after 375.560 msecs
[  420.435750] pcie_mp2_amd 0000:03:00.7: PM: late bus suspend driver flags: 0
[  420.435751] ccp 0000:03:00.2: PM: late bus suspend driver flags: 0
[  420.435753] pci 0000:00:18.7: PM: late bus suspend driver flags: 0
[  420.435753] pci 0000:00:18.6: PM: late bus suspend driver flags: 0
[  420.435754] pci 0000:00:18.5: PM: late bus suspend driver flags: 0
[  420.435754] pci 0000:00:18.4: PM: late bus suspend driver flags: 0
[  420.435757] pci 0000:00:18.2: PM: late bus suspend driver flags: 0
[  420.435757] pci 0000:00:18.1: PM: late bus suspend driver flags: 0
[  420.435757] pci 0000:00:18.0: PM: late bus suspend driver flags: 0
[  420.435759] pci 0000:00:08.0: PM: late bus suspend driver flags: 0
[  420.435760] pci 0000:00:02.0: PM: late bus suspend driver flags: 0
[  420.435760] pci 0000:00:01.0: PM: late bus suspend driver flags: 0
[  420.435761] pci 0000:00:00.0: PM: late bus suspend driver flags: 0
[  420.435892] iwlwifi 0000:01:00.0: PM: late bus suspend driver flags: 0
[  420.435970] snd_hda_intel 0000:03:00.1: PM: late bus suspend driver flags: 0
[  420.435987] snd_hda_intel 0000:03:00.6: PM: late bus suspend driver flags: 0
[  420.435993] snd_rn_pci_acp3x 0000:03:00.5: PM: late bus suspend driver flags: 0
[  420.436004] xhci_hcd 0000:03:00.3: PM: late bus suspend, may wakeup driver flags: 0
[  420.436018] piix4_smbus 0000:00:14.0: PM: late bus suspend driver flags: 0
[  420.436034] k10temp 0000:00:18.3: PM: late bus suspend driver flags: 0
[  420.436104] amdgpu 0000:03:00.0: PM: late bus suspend driver flags: 0
[  420.436132] i2c_hid_acpi i2c-ELAN074E:00: PM: late power domain suspend, may wakeup driver flags: 0
[  420.436145] xhci_hcd 0000:03:00.4: PM: late bus suspend, may wakeup driver flags: 0
[  420.436151] nvme 0000:02:00.0: PM: late bus suspend driver flags: 0
[  420.436174] i2c_designware AMDI0010:03: PM: late power domain suspend driver flags: 6
[  420.436360] pci 0000:00:00.2: PM: late bus suspend driver flags: 0
[  420.436464] acpi-wmi PNP0C14:04: PM: late power domain suspend driver flags: 0
[  420.436472] amd_pmc AMDI0005:00: PM: late power domain suspend driver flags: 0
[  420.436476] ucsi_acpi USBC000:00: PM: late power domain suspend driver flags: 0
[  420.436482] acpi-wmi PNP0C14:03: PM: late power domain suspend driver flags: 0
[  420.436487] acpi-wmi PNP0C14:02: PM: late power domain suspend driver flags: 0
[  420.436492] acpi-wmi PNP0C14:01: PM: late power domain suspend driver flags: 0
[  420.436496] acpi-wmi PNP0C14:00: PM: late power domain suspend driver flags: 0
[  420.436500] amd_gpio AMDI0030:00: PM: late power domain suspend driver flags: 0
[  420.436517] Disabling GPIO #9 interrupt for suspend.
[  420.436546] ac ACPI0003:00: PM: late power domain suspend driver flags: 0
[  420.436556] pci 0000:00:14.3: PM: late bus suspend driver flags: 0
[  420.436562] pcieport 0000:00:02.4: PM: late bus suspend driver flags: 5
[  420.436564] pcieport 0000:00:02.2: PM: late bus suspend driver flags: 5
[  420.436574] pcieport 0000:00:08.1: PM: late bus suspend, may wakeup driver flags: 5
[  420.436951] PM: late suspend of devices complete after 2.256 msecs
[  420.437683] pcie_mp2_amd 0000:03:00.7: PM: noirq bus suspend driver flags: 0
[  420.437685] ccp 0000:03:00.2: PM: noirq bus suspend driver flags: 0
[  420.437686] pci 0000:00:18.7: PM: noirq bus suspend driver flags: 0
[  420.437687] pci 0000:00:18.5: PM: noirq bus suspend driver flags: 0
[  420.437687] pci 0000:00:18.4: PM: noirq bus suspend driver flags: 0
[  420.437687] pci 0000:00:18.6: PM: noirq bus suspend driver flags: 0
[  420.437688] pci 0000:00:18.2: PM: noirq bus suspend driver flags: 0
[  420.437691] pci 0000:00:18.1: PM: noirq bus suspend driver flags: 0
[  420.437692] pci 0000:00:18.0: PM: noirq bus suspend driver flags: 0
[  420.437693] pci 0000:00:08.0: PM: noirq bus suspend driver flags: 0
[  420.437693] pci 0000:00:02.0: PM: noirq bus suspend driver flags: 0
[  420.437695] pci 0000:00:01.0: PM: noirq bus suspend driver flags: 0
[  420.437696] pci 0000:00:00.0: PM: noirq bus suspend driver flags: 0
[  420.437775] snd_hda_intel 0000:03:00.1: PM: noirq bus suspend driver flags: 0
[  420.437809] snd_rn_pci_acp3x 0000:03:00.5: PM: noirq bus suspend driver flags: 0
[  420.437814] xhci_hcd 0000:03:00.3: PM: noirq bus suspend, may wakeup driver flags: 0
[  420.437819] iwlwifi 0000:01:00.0: PM: noirq bus suspend driver flags: 0
[  420.437820] snd_hda_intel 0000:03:00.6: PM: noirq bus suspend driver flags: 0
[  420.437831] k10temp 0000:00:18.3: PM: noirq bus suspend driver flags: 0
[  420.437833] piix4_smbus 0000:00:14.0: PM: noirq bus suspend driver flags: 0
[  420.438437] xhci_hcd 0000:03:00.4: PM: noirq bus suspend, may wakeup driver flags: 0
[  420.438588] i2c_hid_acpi i2c-ELAN074E:00: PM: noirq power domain suspend, may wakeup driver flags: 0
[  420.438597] i2c_designware AMDI0010:03: PM: noirq power domain suspend driver flags: 6
[  420.438601] nvme 0000:02:00.0: PM: noirq bus suspend driver flags: 0
[  420.438704] pci 0000:00:00.2: PM: noirq bus suspend driver flags: 0
[  420.438754] acpi-wmi PNP0C14:04: PM: noirq power domain suspend driver flags: 0
[  420.438758] amd_pmc AMDI0005:00: PM: noirq power domain suspend driver flags: 0
[  420.438760] ucsi_acpi USBC000:00: PM: noirq power domain suspend driver flags: 0
[  420.438763] acpi-wmi PNP0C14:03: PM: noirq power domain suspend driver flags: 0
[  420.438766] acpi-wmi PNP0C14:02: PM: noirq power domain suspend driver flags: 0
[  420.438767] acpi-wmi PNP0C14:01: PM: noirq power domain suspend driver flags: 0
[  420.438769] acpi-wmi PNP0C14:00: PM: noirq power domain suspend driver flags: 0
[  420.438772] amd_gpio AMDI0030:00: PM: noirq power domain suspend driver flags: 0
[  420.438777] ac ACPI0003:00: PM: noirq power domain suspend driver flags: 0
[  420.438784] pci 0000:00:14.3: PM: noirq bus suspend driver flags: 0
[  420.438874] ec PNP0C09:00: PM: noirq driver suspend driver flags: 0
[  420.438876] ACPI: EC: interrupt blocked
[  420.450486] amdgpu 0000:03:00.0: PM: noirq bus suspend driver flags: 0
[  420.462233] pcieport 0000:00:02.4: PM: noirq bus suspend driver flags: 5
[  420.462233] pcieport 0000:00:02.2: PM: noirq bus suspend driver flags: 5
[  420.473775] pcieport 0000:00:08.1: PM: noirq bus suspend, may wakeup driver flags: 5
[  420.474867] PM: noirq suspend of devices complete after 37.601 msecs
[  420.475479] ACPI: \_SB_.PEP_: Successfully transitioned to state screen off
[  420.483599] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms entry
[  420.484027] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 entry
[  420.485199] PM: suspend-to-idle
[  420.485225] amd_pmc: SMU idlemask s0i3: 0xc02e0eb5
[  425.308243] Timekeeping suspended for 4.435 seconds
[  425.308306] PM: Triggering wakeup from IRQ 9
[  425.308318] PM: Triggering wakeup from IRQ 7
[  425.308330] PM: Triggering wakeup from IRQ 0
[  425.308489] ACPI: EC: ACPI EC GPE status set
[  425.308534] ACPI: EC: ACPI EC GPE dispatched
[  425.308874] ACPI: EC: ACPI EC work flushed
[  425.308956] ACPI: PM: Wakeup after ACPI Notify sync
[  425.308959] PM: resume from suspend-to-idle
[  425.309905] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 exit
[  425.316026] ACPI: \_SB_.PEP_: Successfully transitioned to state lps0 ms exit
[  425.317265] ACPI: \_SB_.PEP_: Successfully transitioned to state screen on
[  425.317463] pci 0000:00:00.0: PM: noirq bus resume driver flags: 0
[  425.317489] pci 0000:00:00.2: PM: noirq bus resume driver flags: 0
[  425.317506] pci 0000:00:01.0: PM: noirq bus resume driver flags: 0
[  425.317521] pci 0000:00:02.0: PM: noirq bus resume driver flags: 0
[  425.317537] pcieport 0000:00:02.2: PM: noirq bus resume driver flags: 5
[  425.317673] ec PNP0C09:00: PM: noirq driver resume driver flags: 0
[  425.317675] ACPI: EC: interrupt unblocked
[  425.317692] pcieport 0000:00:02.4: PM: noirq bus resume driver flags: 5
[  425.317717] pci 0000:00:08.0: PM: noirq bus resume driver flags: 0
[  425.317723] pcieport 0000:00:08.1: PM: noirq bus resume driver flags: 5
[  425.317750] pci 0000:00:14.3: PM: noirq bus resume driver flags: 0
[  425.317749] piix4_smbus 0000:00:14.0: PM: noirq bus resume driver flags: 0
[  425.317752] pci 0000:00:18.0: PM: noirq bus resume driver flags: 0
[  425.317758] pci 0000:00:18.1: PM: noirq bus resume driver flags: 0
[  425.317778] pci 0000:00:18.2: PM: noirq bus resume driver flags: 0
[  425.317791] k10temp 0000:00:18.3: PM: noirq bus resume driver flags: 0
[  425.317817] pci 0000:00:18.5: PM: noirq bus resume driver flags: 0
[  425.317819] pci 0000:00:18.4: PM: noirq bus resume driver flags: 0
[  425.317820] pci 0000:00:18.6: PM: noirq bus resume driver flags: 0
[  425.317822] amdgpu 0000:03:00.0: PM: noirq bus resume driver flags: 0
[  425.317822] pci 0000:00:18.7: PM: noirq bus resume driver flags: 0
[  425.317823] i2c_designware AMDI0010:03: PM: noirq power domain resume driver flags: 6
[  425.317824] ccp 0000:03:00.2: PM: noirq bus resume driver flags: 0
[  425.317834] ac ACPI0003:00: PM: noirq power domain resume driver flags: 0
[  425.317835] snd_rn_pci_acp3x 0000:03:00.5: PM: noirq bus resume driver flags: 0
[  425.317835] xhci_hcd 0000:03:00.4: PM: noirq bus resume driver flags: 0
[  425.317835] xhci_hcd 0000:03:00.3: PM: noirq bus resume driver flags: 0
[  425.317845] amd_gpio AMDI0030:00: PM: noirq power domain resume driver flags: 0
[  425.317850] snd_hda_intel 0000:03:00.6: PM: noirq bus resume driver flags: 0
[  425.317851] acpi-wmi PNP0C14:00: PM: noirq power domain resume driver flags: 0
[  425.317854] acpi-wmi PNP0C14:01: PM: noirq power domain resume driver flags: 0
[  425.317859] acpi-wmi PNP0C14:02: PM: noirq power domain resume driver flags: 0
[  425.317867] acpi-wmi PNP0C14:03: PM: noirq power domain resume driver flags: 0
[  425.317867] pcie_mp2_amd 0000:03:00.7: PM: noirq bus resume driver flags: 0
[  425.317872] ucsi_acpi USBC000:00: PM: noirq power domain resume driver flags: 0
[  425.317891] amd_pmc AMDI0005:00: PM: noirq power domain resume driver flags: 0
[  425.317905] acpi-wmi PNP0C14:04: PM: noirq power domain resume driver flags: 0
[  425.317906] i2c_hid_acpi i2c-ELAN074E:00: PM: noirq power domain resume driver flags: 0
[  425.318144] i8042 i8042: PM: noirq driver resume driver flags: 0
[  425.329676] iwlwifi 0000:01:00.0: PM: noirq bus resume driver flags: 0
[  425.331099] snd_hda_intel 0000:03:00.1: PM: noirq bus resume driver flags: 0
[  425.331108] nvme 0000:02:00.0: PM: noirq bus resume driver flags: 0
[  425.347356] PM: noirq resume of devices complete after 30.086 msecs
[  425.347402] GPIO 0 is active: 0x300578e3
[  425.347876] pci 0000:00:00.0: PM: early bus resume driver flags: 0
[  425.347925] pci 0000:00:00.2: PM: early bus resume driver flags: 0
[  425.347927] pci 0000:00:01.0: PM: early bus resume driver flags: 0
[  425.347932] pci 0000:00:02.0: PM: early bus resume driver flags: 0
[  425.347942] pcieport 0000:00:02.2: PM: early bus resume driver flags: 5
[  425.347945] pcieport 0000:00:02.4: PM: early bus resume driver flags: 5
[  425.347949] pci 0000:00:08.0: PM: early bus resume driver flags: 0
[  425.347951] pcieport 0000:00:08.1: PM: early bus resume driver flags: 5
[  425.348034] piix4_smbus 0000:00:14.0: PM: early bus resume driver flags: 0
[  425.348036] pci 0000:00:18.1: PM: early bus resume driver flags: 0
[  425.348036] pci 0000:00:18.0: PM: early bus resume driver flags: 0
[  425.348037] pci 0000:00:14.3: PM: early bus resume driver flags: 0
[  425.348038] k10temp 0000:00:18.3: PM: early bus resume driver flags: 0
[  425.348039] pci 0000:00:18.2: PM: early bus resume driver flags: 0
[  425.348062] pci 0000:00:18.4: PM: early bus resume driver flags: 0
[  425.348062] pci 0000:00:18.5: PM: early bus resume driver flags: 0
[  425.348063] pci 0000:00:18.6: PM: early bus resume driver flags: 0
[  425.348065] pci 0000:00:18.7: PM: early bus resume driver flags: 0
[  425.348067] i2c_designware AMDI0010:03: PM: early power domain resume driver flags: 6
[  425.348068] nvme 0000:02:00.0: PM: early bus resume driver flags: 0
[  425.348085] iwlwifi 0000:01:00.0: PM: early bus resume driver flags: 0
[  425.348090] amdgpu 0000:03:00.0: PM: early bus resume driver flags: 0
[  425.348093] ccp 0000:03:00.2: PM: early bus resume driver flags: 0
[  425.348106] xhci_hcd 0000:03:00.4: PM: early bus resume driver flags: 0
[  425.348107] xhci_hcd 0000:03:00.3: PM: early bus resume driver flags: 0
[  425.348115] snd_rn_pci_acp3x 0000:03:00.5: PM: early bus resume driver flags: 0
[  425.348116] snd_hda_intel 0000:03:00.1: PM: early bus resume driver flags: 0
[  425.348132] snd_hda_intel 0000:03:00.6: PM: early bus resume driver flags: 0
[  425.348157] pcie_mp2_amd 0000:03:00.7: PM: early bus resume driver flags: 0
[  425.348306] i2c_hid_acpi i2c-ELAN074E:00: PM: early power domain resume driver flags: 0
[  425.349240] ac ACPI0003:00: PM: early power domain resume driver flags: 0
[  425.349249] amd_gpio AMDI0030:00: PM: early power domain resume driver flags: 0
[  425.349285] acpi-wmi PNP0C14:00: PM: early power domain resume driver flags: 0
[  425.349288] acpi-wmi PNP0C14:01: PM: early power domain resume driver flags: 0
[  425.349291] acpi-wmi PNP0C14:02: PM: early power domain resume driver flags: 0
[  425.349294] acpi-wmi PNP0C14:03: PM: early power domain resume driver flags: 0
[  425.349298] ucsi_acpi USBC000:00: PM: early power domain resume driver flags: 0
[  425.349301] amd_pmc AMDI0005:00: PM: early power domain resume driver flags: 0
[  425.349306] acpi-wmi PNP0C14:04: PM: early power domain resume driver flags: 0
[  425.349693] PM: early resume of devices complete after 2.044 msecs
[  425.349767] pci 0000:00:00.0: PM: bus resume driver flags: 0
[  425.349777] pci 0000:00:00.2: PM: bus resume driver flags: 0
[  425.349778] pci 0000:00:01.0: PM: bus resume driver flags: 0
[  425.349782] pcieport 0000:00:02.2: PM: bus resume driver flags: 5
[  425.349783] pci 0000:00:02.0: PM: bus resume driver flags: 0
[  425.349785] pcieport 0000:00:02.4: PM: bus resume driver flags: 5
[  425.349789] pci 0000:00:08.0: PM: bus resume driver flags: 0
[  425.349793] pcieport 0000:00:08.1: PM: bus resume driver flags: 5
[  425.349799] piix4_smbus 0000:00:14.0: PM: bus resume driver flags: 0
[  425.349819] pci 0000:00:14.3: PM: bus resume driver flags: 0
[  425.349820] pci 0000:00:18.1: PM: bus resume driver flags: 0
[  425.349820] pci 0000:00:18.0: PM: bus resume driver flags: 0
[  425.349822] pci 0000:00:18.2: PM: bus resume driver flags: 0
[  425.349823] pci 0000:00:18.4: PM: bus resume driver flags: 0
[  425.349824] pci 0000:00:18.5: PM: bus resume driver flags: 0
[  425.349824] k10temp 0000:00:18.3: PM: bus resume driver flags: 0
[  425.349826] pci 0000:00:18.6: PM: bus resume driver flags: 0
[  425.349827] i2c_designware AMDI0010:03: PM: power domain resume driver flags: 6
[  425.349827] pci 0000:00:18.7: PM: bus resume driver flags: 0
[  425.349828] iwlwifi 0000:01:00.0: PM: bus resume driver flags: 0
[  425.349841] nvme 0000:02:00.0: PM: bus resume driver flags: 0
[  425.349853] i2c_hid_acpi i2c-ELAN074E:00: PM: power domain resume driver flags: 0
[  425.349948] regulator regulator.0: PM: class resume driver flags: 0
[  425.350051] ec PNP0C09:00: PM: driver resume driver flags: 0
[  425.350095] battery PNP0C0A:00: PM: driver resume driver flags: 0
[  425.350095] ieee80211 phy0: PM: class resume driver flags: 0
[  425.350128] amdgpu 0000:03:00.0: PM: bus resume driver flags: 0
[  425.350131] ccp 0000:03:00.2: PM: bus resume driver flags: 0
[  425.350136] xhci_hcd 0000:03:00.4: PM: bus resume driver flags: 0
[  425.350138] xhci_hcd 0000:03:00.3: PM: bus resume driver flags: 0
[  425.350144] snd_rn_pci_acp3x 0000:03:00.5: PM: bus resume driver flags: 0
[  425.350408] snd_hda_intel 0000:03:00.6: PM: bus resume driver flags: 0
[  425.350425] pcie_mp2_amd 0000:03:00.7: PM: bus resume driver flags: 0
[  425.350704] button PNP0C0C:00: PM: driver resume driver flags: 0
[  425.350798] tpm_crb MSFT0101:00: PM: driver resume driver flags: 0
[  425.350807] button PNP0C0D:00: PM: driver resume driver flags: 0
[  425.351423] thermal LNXTHERM:00: PM: driver resume driver flags: 0
[  425.351433] thermal LNXTHERM:01: PM: driver resume driver flags: 0
[  425.351450] platform PNP0800:00: PM: bus resume driver flags: 0
[  425.351453] platform PNP0C09:00: PM: bus resume driver flags: 0
[  425.351457] ac ACPI0003:00: PM: power domain resume driver flags: 0
[  425.352422] usb usb3: PM: type resume driver flags: 0
[  425.352424] usb usb4: PM: type resume driver flags: 0
[  425.352731] usb usb1: PM: type resume driver flags: 0
[  425.352735] usb usb2: PM: type resume driver flags: 0
[  425.352823] [drm] PCIE GART of 1024M enabled.
[  425.352825] [drm] PTB located at 0x000000F41FC00000
[  425.352851] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  425.352868] usb 1-3: PM: type resume driver flags: 0
[  425.352880] usb 1-4: PM: type resume driver flags: 0
[  425.353947] amdgpu 0000:03:00.0: amdgpu: dpm has been disabled
[  425.355205] snd_hda_codec_realtek hdaudioC1D0: PM: driver resume driver flags: 0
[  425.355464] platform PNP0C0A:00: PM: bus resume driver flags: 0
[  425.355469] platform HPIC0003:00: PM: bus resume driver flags: 0
[  425.355471] platform PNP0C0C:00: PM: bus resume driver flags: 0
[  425.355473] platform acpi-cpufreq: PM: bus resume driver flags: 0
[  425.355475] amd_gpio AMDI0030:00: PM: power domain resume driver flags: 0
[  425.355478] platform MSFT0101:00: PM: bus resume driver flags: 0
[  425.355480] acpi-wmi PNP0C14:00: PM: power domain resume driver flags: 0
[  425.355483] acpi-wmi PNP0C14:01: PM: power domain resume driver flags: 0
[  425.355485] acpi-wmi PNP0C14:02: PM: power domain resume driver flags: 0
[  425.355487] platform PNP0C0D:00: PM: bus resume driver flags: 0
[  425.355489] acpi-wmi PNP0C14:03: PM: power domain resume driver flags: 0
[  425.355491] platform ACPI000E:00: PM: bus resume driver flags: 0
[  425.355493] ucsi_acpi USBC000:00: PM: power domain resume driver flags: 0
[  425.355500] amd_pmc AMDI0005:00: PM: power domain resume driver flags: 0
[  425.355503] acpi-fan PNP0C0B:00: PM: bus resume driver flags: 0
[  425.355506] platform PNP0103:00: PM: bus resume driver flags: 0
[  425.355508] acpi-wmi PNP0C14:04: PM: power domain resume driver flags: 0
[  425.355514] platform rtc-efi.0: PM: bus resume driver flags: 0
[  425.355516] platform efivars.0: PM: bus resume driver flags: 0
[  425.355522] system 00:00: PM: bus resume driver flags: 0
[  425.355525] rtc_cmos 00:01: PM: bus resume driver flags: 0
[  425.355529] i8042 kbd 00:02: PM: bus resume driver flags: 0
[  425.355531] system 00:03: PM: bus resume driver flags: 0
[  425.355593] pcspkr pcspkr: PM: bus resume driver flags: 0
[  425.355639] serial8250 serial8250: PM: bus resume driver flags: 0
[  425.355644] port serial8250:0.0: PM: driver resume driver flags: 0
[  425.355647] port serial8250:0.1: PM: driver resume driver flags: 0
[  425.355651] port serial8250:0.2: PM: driver resume driver flags: 0
[  425.355654] port serial8250:0.3: PM: driver resume driver flags: 0
[  425.355661] i8042 i8042: PM: bus resume driver flags: 0
[  425.355665] atkbd serio0: PM: bus resume driver flags: 0
[  425.355671] rtc rtc0: PM: class resume driver flags: 0
[  425.355674] alarmtimer alarmtimer.0.auto: PM: bus resume driver flags: 0
[  425.355679] input input0: PM: type resume driver flags: 0
[  425.355684] leds input0::numlock: PM: class resume driver flags: 0
[  425.355686] leds input0::capslock: PM: class resume driver flags: 0
[  425.355689] leds input0::scrolllock: PM: class resume driver flags: 0
[  425.355704] platform microcode: PM: bus resume driver flags: 0
[  425.355728] input input1: PM: type resume driver flags: 0
[  425.355739] input input2: PM: type resume driver flags: 0
[  425.355743] input input3: PM: type resume driver flags: 0
[  425.357967] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[  425.379303] usb 4-1: PM: type resume driver flags: 0
[  425.406461] usb 3-3: PM: type resume driver flags: 0
[  425.416851] input input7: PM: type resume driver flags: 0
[  425.416862] input input9: PM: type resume driver flags: 0
[  425.455212] scsi host0: PM: bus resume driver flags: 0
[  425.455222] scsi target0:0:0: PM: bus resume driver flags: 0
[  425.455227] sd 0:0:0:0: PM: bus resume driver flags: 0
[  425.464745] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[  425.464748] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  425.464750] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  425.464751] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[  425.464752] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[  425.464752] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[  425.464753] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[  425.464754] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[  425.464755] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[  425.464756] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
[  425.464757] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
[  425.464758] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
[  425.464759] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
[  425.464760] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
[  425.464761] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
[  425.476660] snd_hda_intel 0000:03:00.1: PM: bus resume driver flags: 0
[  425.476683] backlight amdgpu_bl0: PM: class resume driver flags: 0
[  425.476918] input input10: PM: type resume driver flags: 0
[  425.476936] sp5100-tco sp5100-tco: PM: bus resume driver flags: 0
[  425.476949] platform regulatory.0: PM: bus resume driver flags: 0
[  425.476960] acp_rn_pdm_dma acp_rn_pdm_dma.0: PM: bus resume driver flags: 0
[  425.476967] dmic-codec dmic-codec.0: PM: bus resume driver flags: 0
[  425.476971] input input11: PM: type resume driver flags: 0
[  425.476978] hp-wmi hp-wmi: PM: bus resume driver flags: 0
[  425.477832] rfkill rfkill0: PM: class resume driver flags: 0
[  425.477857] intel_rapl_msr intel_rapl_msr.0: PM: bus resume driver flags: 0
[  425.478959] input input12: PM: type resume driver flags: 0
[  425.478966] leds hda::mute: PM: class resume driver flags: 0
[  425.478993] input input13: PM: type resume driver flags: 0
[  425.478996] input input14: PM: type resume driver flags: 0
[  425.479001] acp_pdm_mach acp_pdm_mach.0: PM: bus resume driver flags: 0
[  425.479032] leds phy0-led: PM: class resume driver flags: 0
[  425.479036] rfkill rfkill1: PM: class resume driver flags: 0
[  425.479086] PM: resume of devices complete after 129.390 msecs
[  425.479242] snd_hda_codec_realtek hdaudioC1D0: PM: completing driver resume driver flags: 0
[  425.479249] snd_hda_codec_hdmi hdaudioC0D0: PM: completing driver resume driver flags: 0
[  425.479311] usb 4-1: PM: completing type resume driver flags: 0
[  425.479334] usb 1-4: PM: completing type resume driver flags: 0
[  425.479343] usb 3-3: PM: completing type resume driver flags: 0
[  425.479348] usb 1-3: PM: completing type resume driver flags: 0
[  425.479359] usb usb4: PM: completing type resume driver flags: 0
[  425.479368] usb usb3: PM: completing type resume driver flags: 0
[  425.479377] usb usb2: PM: completing type resume driver flags: 0
[  425.479387] usb usb1: PM: completing type resume driver flags: 0
[  425.479502] snd_hda_intel 0000:03:00.1: PM: completing bus resume driver flags: 0
[  425.479573] i2c_hid_acpi i2c-ELAN074E:00: PM: completing power domain resume driver flags: 0
[  425.479578] acpi-wmi PNP0C14:04: PM: completing power domain resume driver flags: 0
[  425.479581] amd_pmc AMDI0005:00: PM: completing power domain resume driver flags: 0
[  425.479584] ucsi_acpi USBC000:00: PM: completing power domain resume driver flags: 0
[  425.479587] acpi-wmi PNP0C14:03: PM: completing power domain resume driver flags: 0
[  425.479590] acpi-wmi PNP0C14:02: PM: completing power domain resume driver flags: 0
[  425.479592] acpi-wmi PNP0C14:01: PM: completing power domain resume driver flags: 0
[  425.479594] acpi-wmi PNP0C14:00: PM: completing power domain resume driver flags: 0
[  425.479597] i2c_designware AMDI0010:03: PM: completing power domain resume driver flags: 6
[  425.479600] amd_gpio AMDI0030:00: PM: completing power domain resume driver flags: 0
[  425.479605] ac ACPI0003:00: PM: completing power domain resume driver flags: 0
[  425.479609] pcie_mp2_amd 0000:03:00.7: PM: completing bus resume driver flags: 0
[  425.479611] snd_hda_intel 0000:03:00.6: PM: completing bus resume driver flags: 0
[  425.479615] snd_rn_pci_acp3x 0000:03:00.5: PM: completing bus resume driver flags: 0
[  425.479618] xhci_hcd 0000:03:00.4: PM: completing bus resume driver flags: 0
[  425.479732] xhci_hcd 0000:03:00.3: PM: completing bus resume driver flags: 0
[  425.479830] ccp 0000:03:00.2: PM: completing bus resume driver flags: 0
[  425.479832] amdgpu 0000:03:00.0: PM: completing bus resume driver flags: 0
[  425.479836] nvme 0000:02:00.0: PM: completing bus resume driver flags: 0
[  425.479839] iwlwifi 0000:01:00.0: PM: completing bus resume driver flags: 0
[  425.479842] pci 0000:00:18.7: PM: completing bus resume driver flags: 0
[  425.479844] pci 0000:00:18.6: PM: completing bus resume driver flags: 0
[  425.479846] pci 0000:00:18.5: PM: completing bus resume driver flags: 0
[  425.479848] pci 0000:00:18.4: PM: completing bus resume driver flags: 0
[  425.479850] k10temp 0000:00:18.3: PM: completing bus resume driver flags: 0
[  425.479852] pci 0000:00:18.2: PM: completing bus resume driver flags: 0
[  425.479854] pci 0000:00:18.1: PM: completing bus resume driver flags: 0
[  425.479856] pci 0000:00:18.0: PM: completing bus resume driver flags: 0
[  425.479858] pci 0000:00:14.3: PM: completing bus resume driver flags: 0
[  425.479860] piix4_smbus 0000:00:14.0: PM: completing bus resume driver flags: 0
[  425.479862] pcieport 0000:00:08.1: PM: completing bus resume driver flags: 5
[  425.479864] pci 0000:00:08.0: PM: completing bus resume driver flags: 0
[  425.479866] pcieport 0000:00:02.4: PM: completing bus resume driver flags: 5
[  425.479869] pcieport 0000:00:02.2: PM: completing bus resume driver flags: 5
[  425.479871] pci 0000:00:02.0: PM: completing bus resume driver flags: 0
[  425.479873] pci 0000:00:01.0: PM: completing bus resume driver flags: 0
[  425.479875] pci 0000:00:00.2: PM: completing bus resume driver flags: 0
[  425.479877] pci 0000:00:00.0: PM: completing bus resume driver flags: 0
[  425.480947] OOM killer enabled.
[  425.480950] Restarting tasks: Starting
[  425.484841] Restarting tasks: Done
[  425.484872] random: crng reseeded on system resumption
[  425.497492] PM: suspend exit
[  425.522649] nvme nvme0: 8/0/0 default/read/poll queues
[  425.626534] wlp1s0: authenticate with d6:92:5e:eb:ee:15 (local address=c8:15:4e:63:1d:e8)
[  425.627989] wlp1s0: send auth to d6:92:5e:eb:ee:15 (try 1/3)
[  425.673199] wlp1s0: authenticated
[  425.675005] wlp1s0: associate with d6:92:5e:eb:ee:15 (try 1/3)
[  425.683276] wlp1s0: RX AssocResp from d6:92:5e:eb:ee:15 (capab=0x1011 status=0 aid=22)
[  425.696465] wlp1s0: associated
[  425.752282] wlp1s0: Limiting TX power to 23 (23 - 0) dBm as advertised by d6:92:5e:eb:ee:15
[  429.576385] PM: suspend entry (s2idle)
[  429.933653] Filesystems sync: 0.357 seconds
[  429.934172] Freezing user space processes
[  429.936426] Freezing user space processes completed (elapsed 0.002 seconds)
[  429.936430] OOM killer disabled.
[  429.936432] Freezing remaining freezable tasks
[  429.937694] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  429.937697] printk: Suspending console(s) (use no_console_suspend to debug)
[  430.199580] PM: suspend of devices aborted after 0.844 msecs
[  430.199586] PM: start suspend of devices aborted after 261.863 msecs
[  430.199588] PM: Some devices failed to suspend, or early wake event detected
[  430.199709]  memory: Attempt to enable runtime PM when it is blocked
[  430.199771] i2c i2c-3: Unbalanced pm_runtime_enable!
[  430.199780] snd_hda_codec_hdmi hdaudioC0D0: PM: driver resume driver flags: 0
[  430.199785] snd_hda_codec_hdmi hdaudioC0D0: Unbalanced pm_runtime_enable!
[  430.199789] CPU: 2 UID: 0 PID: 2508 Comm: amd_s2idle.py Not tainted 6.15.0-09120-g17abf5027caf #441 PREEMPT(voluntary) 
[  430.199792] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  430.199793] Call Trace:
[  430.199794]  <TASK>
[  430.199795]  dump_stack_lvl+0x6e/0x90
[  430.199801]  pm_runtime_enable.cold+0x28/0x48
[  430.199803]  device_resume+0x47/0x220
[  430.199807]  dpm_resume+0x210/0x350
[  430.199810]  dpm_resume_end+0x11/0x20
[  430.199812]  suspend_devices_and_enter+0x18e/0x9f0
[  430.199817]  pm_suspend.cold+0x273/0x2cf
[  430.199820]  state_store+0x6c/0xd0
[  430.199823]  kernfs_fop_write_iter+0x194/0x250
[  430.199827]  vfs_write+0x254/0x550
[  430.199834]  ksys_write+0x71/0xe0
[  430.199837]  do_syscall_64+0x97/0x3d0
[  430.199839]  ? find_held_lock+0x2b/0x80
[  430.199842]  ? kernfs_fop_llseek+0x77/0xd0
[  430.199844]  ? lock_release+0xd1/0x2a0
[  430.199848]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.199851]  ? __lock_acquire+0x469/0x2200
[  430.199853]  ? kernfs_fop_llseek+0x77/0xd0
[  430.199858]  ? lock_acquire+0xc9/0x2d0
[  430.199860]  ? kernfs_fop_llseek+0x35/0xd0
[  430.199863]  ? __lock_acquire+0x469/0x2200
[  430.199868]  ? find_held_lock+0x2b/0x80
[  430.199869]  ? kernfs_fop_llseek+0x77/0xd0
[  430.199871]  ? lock_release+0xd1/0x2a0
[  430.199875]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.199879]  ? kernfs_fop_llseek+0x77/0xd0
[  430.199882]  ? ksys_lseek+0x39/0x90
[  430.199883] uvcvideo 1-3:1.0: Unbalanced pm_runtime_enable!
[  430.199884]  ? do_syscall_64+0x170/0x3d0
[  430.199885]  ? do_syscall_64+0x170/0x3d0
[  430.199886]  ? do_syscall_64+0x170/0x3d0
[  430.199889] usb 1-4:1.0: Attempt to enable runtime PM when it is blocked
[  430.199889]  ? do_syscall_64+0x170/0x3d0
[  430.199890]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  430.199892] ee1004 3-0050: Attempt to enable runtime PM when it is blocked
[  430.199893] ee1004 3-0051: Attempt to enable runtime PM when it is blocked
[  430.199894]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  430.199895] RIP: 0033:0x7f0a53bab0d0
[  430.199898] btusb 3-3:1.1: Unbalanced pm_runtime_enable!
[  430.199898] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  430.199900] RSP: 002b:00007ffddbf30728 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  430.199902] RAX: ffffffffffffffda RBX: 0000000000a794f0 RCX: 00007f0a53bab0d0
[  430.199902] RDX: 0000000000000003 RSI: 000000002073d5d0 RDI: 0000000000000004
[  430.199903] RBP: 00007f0a53aa5fe8 R08: 0000000000000000 R09: 0000000000000002
[  430.199904] R10: 0000000000000007 R11: 0000000000000202 R12: 0000000000000003
[  430.199904] R13: 0000000000000004 R14: 000000002073d5d0 R15: 0000000000a4bb48
[  430.199912]  </TASK>
[  430.199914] CPU: 0 UID: 0 PID: 114 Comm: kworker/u64:3 Not tainted 6.15.0-09120-g17abf5027caf #441 PREEMPT(voluntary) 
[  430.199916] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  430.199918] Workqueue: async async_run_entry_fn
[  430.199922] Call Trace:
[  430.199924]  <TASK>
[  430.199924] memory memory0: Attempt to enable runtime PM when it is blocked
[  430.199926]  dump_stack_lvl+0x6e/0x90
[  430.199931]  pm_runtime_enable.cold+0x28/0x48
[  430.199934]  device_resume+0x47/0x220
[  430.199939]  async_resume+0x1d/0x30
[  430.199942]  async_run_entry_fn+0x2e/0x130
[  430.199947]  process_one_work+0x22b/0x5b0
[  430.199953]  worker_thread+0x1da/0x3d0
[  430.199956]  ? bh_worker+0x260/0x260
[  430.199957]  kthread+0x10a/0x250
[  430.199959]  ? kthreads_online_cpu+0x130/0x130
[  430.199961]  ret_from_fork+0x20c/0x270
[  430.199964]  ? kthreads_online_cpu+0x130/0x130
[  430.199965]  ret_from_fork_asm+0x11/0x20
[  430.199973]  </TASK>
[  430.199975] CPU: 2 UID: 0 PID: 2508 Comm: amd_s2idle.py Not tainted 6.15.0-09120-g17abf5027caf #441 PREEMPT(voluntary) 
[  430.199978] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  430.199978] Call Trace:
[  430.199979]  <TASK>
[  430.199980]  dump_stack_lvl+0x6e/0x90
[  430.199982]  pm_runtime_enable.cold+0x28/0x48
[  430.199984]  device_resume+0x47/0x220
[  430.199986]  dpm_resume+0x210/0x350
[  430.199989]  dpm_resume_end+0x11/0x20
[  430.199990]  suspend_devices_and_enter+0x18e/0x9f0
[  430.199993]  pm_suspend.cold+0x273/0x2cf
[  430.199995]  state_store+0x6c/0xd0
[  430.199997]  kernfs_fop_write_iter+0x194/0x250
[  430.200000]  vfs_write+0x254/0x550
[  430.200005]  ksys_write+0x71/0xe0
[  430.200007]  do_syscall_64+0x97/0x3d0
[  430.200009]  ? find_held_lock+0x2b/0x80
[  430.200010]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200012]  ? lock_release+0xd1/0x2a0
[  430.200015]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.200017]  ? __lock_acquire+0x469/0x2200
[  430.200019]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200022]  ? lock_acquire+0xc9/0x2d0
[  430.200024]  ? kernfs_fop_llseek+0x35/0xd0
[  430.200027]  ? __lock_acquire+0x469/0x2200
[  430.200030]  ? find_held_lock+0x2b/0x80
[  430.200031]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200033]  ? lock_release+0xd1/0x2a0
[  430.200036]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.200038]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200041]  ? ksys_lseek+0x39/0x90
[  430.200042]  ? do_syscall_64+0x170/0x3d0
[  430.200043]  ? do_syscall_64+0x170/0x3d0
[  430.200044]  ? do_syscall_64+0x170/0x3d0
[  430.200046]  ? do_syscall_64+0x170/0x3d0
[  430.200046]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  430.200048]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  430.200049] RIP: 0033:0x7f0a53bab0d0
[  430.200050] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  430.200051] RSP: 002b:00007ffddbf30728 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  430.200051] RAX: ffffffffffffffda RBX: 0000000000a794f0 RCX: 00007f0a53bab0d0
[  430.200052] RDX: 0000000000000003 RSI: 000000002073d5d0 RDI: 0000000000000004
[  430.200052] RBP: 00007f0a53aa5fe8 R08: 0000000000000000 R09: 0000000000000002
[  430.200053] R10: 0000000000000007 R11: 0000000000000202 R12: 0000000000000003
[  430.200053] R13: 0000000000000004 R14: 000000002073d5d0 R15: 0000000000a4bb48
[  430.200058]  </TASK>
[  430.200060] memory memory1: Attempt to enable runtime PM when it is blocked
[  430.200059] CPU: 11 UID: 0 PID: 2532 Comm: kworker/u64:32 Not tainted 6.15.0-09120-g17abf5027caf #441 PREEMPT(voluntary) 
[  430.200062] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  430.200062] Workqueue: async async_run_entry_fn
[  430.200065] Call Trace:
[  430.200066]  <TASK>
[  430.200068]  dump_stack_lvl+0x6e/0x90
[  430.200071]  pm_runtime_enable.cold+0x28/0x48
[  430.200073]  device_resume+0x47/0x220
[  430.200076]  async_resume+0x1d/0x30
[  430.200077]  async_run_entry_fn+0x2e/0x130
[  430.200080]  process_one_work+0x22b/0x5b0
[  430.200085]  worker_thread+0x1da/0x3d0
[  430.200088]  ? bh_worker+0x260/0x260
[  430.200089]  kthread+0x10a/0x250
[  430.200091]  ? kthreads_online_cpu+0x130/0x130
[  430.200093]  ret_from_fork+0x20c/0x270
[  430.200094]  ? kthreads_online_cpu+0x130/0x130
[  430.200095]  ret_from_fork_asm+0x11/0x20
[  430.200102]  </TASK>
[  430.200103] CPU: 2 UID: 0 PID: 2508 Comm: amd_s2idle.py Not tainted 6.15.0-09120-g17abf5027caf #441 PREEMPT(voluntary) 
[  430.200104] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  430.200104] Call Trace:
[  430.200104]  <TASK>
[  430.200105]  dump_stack_lvl+0x6e/0x90
[  430.200107]  pm_runtime_enable.cold+0x28/0x48
[  430.200108]  device_resume+0x47/0x220
[  430.200110]  dpm_resume+0x210/0x350
[  430.200113]  dpm_resume_end+0x11/0x20
[  430.200114]  suspend_devices_and_enter+0x18e/0x9f0
[  430.200117]  pm_suspend.cold+0x273/0x2cf
[  430.200119]  state_store+0x6c/0xd0
[  430.200121]  kernfs_fop_write_iter+0x194/0x250
[  430.200123]  vfs_write+0x254/0x550
[  430.200128]  ksys_write+0x71/0xe0
[  430.200130]  do_syscall_64+0x97/0x3d0
[  430.200132]  ? find_held_lock+0x2b/0x80
[  430.200133]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200135]  ? lock_release+0xd1/0x2a0
[  430.200138]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.200140]  ? __lock_acquire+0x469/0x2200
[  430.200141]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200144]  ? lock_acquire+0xc9/0x2d0
[  430.200146]  ? kernfs_fop_llseek+0x35/0xd0
[  430.200149]  ? __lock_acquire+0x469/0x2200
[  430.200152]  ? find_held_lock+0x2b/0x80
[  430.200153]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200155]  ? lock_release+0xd1/0x2a0
[  430.200158]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.200160]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200163]  ? ksys_lseek+0x39/0x90
[  430.200164]  ? do_syscall_64+0x170/0x3d0
[  430.200165]  ? do_syscall_64+0x170/0x3d0
[  430.200166]  ? do_syscall_64+0x170/0x3d0
[  430.200167]  ? do_syscall_64+0x170/0x3d0
[  430.200168]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  430.200170]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  430.200171] RIP: 0033:0x7f0a53bab0d0
[  430.200172] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  430.200172] RSP: 002b:00007ffddbf30728 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  430.200173] RAX: ffffffffffffffda RBX: 0000000000a794f0 RCX: 00007f0a53bab0d0
[  430.200173] RDX: 0000000000000003 RSI: 000000002073d5d0 RDI: 0000000000000004
[  430.200173] RBP: 00007f0a53aa5fe8 R08: 0000000000000000 R09: 0000000000000002
[  430.200174] R10: 0000000000000007 R11: 0000000000000202 R12: 0000000000000003
[  430.200174] R13: 0000000000000004 R14: 000000002073d5d0 R15: 0000000000a4bb48
[  430.200179]  </TASK>
[  430.200180] memory memory2: Attempt to enable runtime PM when it is blocked
[  430.200180] CPU: 15 UID: 0 PID: 2525 Comm: kworker/u64:25 Not tainted 6.15.0-09120-g17abf5027caf #441 PREEMPT(voluntary) 
[  430.200182] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  430.200183] Workqueue: async async_run_entry_fn
[  430.200186] Call Trace:
[  430.200187]  <TASK>
[  430.200189]  dump_stack_lvl+0x6e/0x90
[  430.200192]  pm_runtime_enable.cold+0x28/0x48
[  430.200194]  device_resume+0x47/0x220
[  430.200199]  async_resume+0x1d/0x30
[  430.200200]  async_run_entry_fn+0x2e/0x130
[  430.200203]  process_one_work+0x22b/0x5b0
[  430.200208]  worker_thread+0x1da/0x3d0
[  430.200211]  ? bh_worker+0x260/0x260
[  430.200212]  kthread+0x10a/0x250
[  430.200214]  ? kthreads_online_cpu+0x130/0x130
[  430.200216]  ret_from_fork+0x20c/0x270
[  430.200217]  ? kthreads_online_cpu+0x130/0x130
[  430.200218]  ret_from_fork_asm+0x11/0x20
[  430.200225]  </TASK>
[  430.200226] CPU: 2 UID: 0 PID: 2508 Comm: amd_s2idle.py Not tainted 6.15.0-09120-g17abf5027caf #441 PREEMPT(voluntary) 
[  430.200227] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  430.200227] Call Trace:
[  430.200227]  <TASK>
[  430.200228]  dump_stack_lvl+0x6e/0x90
[  430.200230]  pm_runtime_enable.cold+0x28/0x48
[  430.200231]  device_resume+0x47/0x220
[  430.200233]  dpm_resume+0x210/0x350
[  430.200235]  dpm_resume_end+0x11/0x20
[  430.200237]  suspend_devices_and_enter+0x18e/0x9f0
[  430.200239]  pm_suspend.cold+0x273/0x2cf
[  430.200241]  state_store+0x6c/0xd0
[  430.200243]  kernfs_fop_write_iter+0x194/0x250
[  430.200246]  vfs_write+0x254/0x550
[  430.200251]  ksys_write+0x71/0xe0
[  430.200253]  do_syscall_64+0x97/0x3d0
[  430.200254]  ? find_held_lock+0x2b/0x80
[  430.200255]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200257]  ? lock_release+0xd1/0x2a0
[  430.200260]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.200262]  ? __lock_acquire+0x469/0x2200
[  430.200264]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200267]  ? lock_acquire+0xc9/0x2d0
[  430.200268]  ? kernfs_fop_llseek+0x35/0xd0
[  430.200271]  ? __lock_acquire+0x469/0x2200
[  430.200275]  ? find_held_lock+0x2b/0x80
[  430.200276]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200278]  ? lock_release+0xd1/0x2a0
[  430.200281]  ? __mutex_unlock_slowpath+0x3c/0x2c0
[  430.200284]  ? kernfs_fop_llseek+0x77/0xd0
[  430.200286]  ? ksys_lseek+0x39/0x90
[  430.200287]  ? do_syscall_64+0x170/0x3d0
[  430.200288]  ? do_syscall_64+0x170/0x3d0
[  430.200289]  ? do_syscall_64+0x170/0x3d0
[  430.200291]  ? do_syscall_64+0x170/0x3d0
[  430.200291]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
[  430.200293]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  430.200294] RIP: 0033:0x7f0a53bab0d0
[  430.200295] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  430.200295] RSP: 002b:00007ffddbf30728 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  430.200296] RAX: ffffffffffffffda RBX: 0000000000a794f0 RCX: 00007f0a53bab0d0
[  430.200296] RDX: 0000000000000003 RSI: 000000002073d5d0 RDI: 0000000000000004
[  430.200296] RBP: 00007f0a53aa5fe8 R08: 0000000000000000 R09: 0000000000000002
[  430.200297] R10: 0000000000000007 R11: 0000000000000202 R12: 0000000000000003
[  430.200297] R13: 0000000000000004 R14: 000000002073d5d0 R15: 0000000000a4bb48
[  430.200302]  </TASK>
[  430.200304] memory memory3: Attempt to enable runtime PM when it is blocked
... (stacktraces repeat for thousands of lines)

