Return-Path: <linux-pm+bounces-23215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4FA4AC56
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 15:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35364188F59F
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F071E1025;
	Sat,  1 Mar 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="2wnOSSQH"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00E3594D;
	Sat,  1 Mar 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740840057; cv=none; b=g77Xt84lBCXWDCUMUihQYUdS9pSv7X2Mr6R+F1nQVjOs5zQE471VZtQvUglxJCKptR4ZhYhBQ7NNJx9WdWveGqwtPZIKySFUNIK0U/8Ov2LIPRAHWuAQFE7jAehg9tsimx040ypqtcyNpDs391bWySm4lf20oSuugTQXARYzUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740840057; c=relaxed/simple;
	bh=fvc0GFY49vtdwlvQOiX7jyfeQ4jH4gnCmwZDVEIASPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDSs23hR4YkafXdAZ8Nuxq0bkJ9vrzEWESvCE7q3CUgtDNGFgB97N8en6VgfCgH5sm+VsqRikFcJ53iKI1sxn3Y66c+e3ZfamPxUTFboPGrB0TakE9wSUetLtV8yPSDypMKlxsX51GydQNRWTXTI08olKntDFJUpCJsUY5YOQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=2wnOSSQH; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id C5C4F2E09033;
	Sat,  1 Mar 2025 16:40:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740840052;
	bh=AoF13J8yxL2hOUdDriZFd3dGmbL2Va9UciqCeTZ8KJA=;
	h=Received:From:Subject:To;
	b=2wnOSSQHKbiBiN0xpQiZcmFHZGrPxuwn8AxwU2wYYk/Zsefd97BBhHUO0+1mz58Zp
	 ge1S8jigIpJhwWGV4CN+ffyPOXT8u7U0qWIPCy1BNQaX5XvJM4F/EPGMCr1LKlSY5R
	 WwGv/7mRSJKZGoi4hEsjfidyEragpIW9myhC9dAY=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f173.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-30a2d4b61e4so26137001fa.1;
        Sat, 01 Mar 2025 06:40:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW0BQm72A/YNRKIYyrBx8iJVtTcr0VpHq/E213O2J+Sfy0gu5PomN497DPSZLU3NJAzVCWcjD2MYOqYMngK1nn7RjpP8Q==@vger.kernel.org,
 AJvYcCWK5hxS55+SnhvNH++WT3bvReAbKa3HNbmUc6gEF4v2J1/h3BAupzUw90KArhTcsd4BIx0wBwAlukI=@vger.kernel.org,
 AJvYcCWc0rgUpNkOgnL4ghQP/bR2RpELrt6ruBgSJY/gAdtFetbkwf2mtYWFASk3+8QTl4AovGnKdRjAA+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhP4xsWAMEPBlL6WCDUg54r0+NwFrkra9DPJCMPiRmk3r78XB
	vrFmYh3LnhHb8ESwkkGBM19iwPI34b6JHt6/A8z7MOz71EhKaRsLFTpmwYQq0yx7fFmTGn1ACXp
	88rTfiMYWOGJeGVLYmi4wJi0KP/M=
X-Google-Smtp-Source: 
 AGHT+IF42FFJSZGsRTc4ejVijbncPKYRFc6Y7m4mFVtrifwjxPS4IMR2tLWBSG+1P79JGvqbybjaFQY+khTKeEv/KwU=
X-Received: by 2002:a2e:be03:0:b0:309:1d7b:f027 with SMTP id
 38308e7fff4ca-30b9320f37bmr29454671fa.9.1740840051093; Sat, 01 Mar 2025
 06:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222161824.172511-12-lkml@antheas.dev>
 <202503012254.EtBZW7gW-lkp@intel.com>
In-Reply-To: <202503012254.EtBZW7gW-lkp@intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 15:40:40 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFcVDMPeUqHP_S+Prf=TkvPQ3UEMVGbF9SGMcXMxRAf8w@mail.gmail.com>
X-Gm-Features: AQ5f1JqR03mBJLIvKw2lTHt6pPHFgGDzKan73hLzrnP8lmbF4yL3QOPCUXJkAJM
Message-ID: 
 <CAGwozwFcVDMPeUqHP_S+Prf=TkvPQ3UEMVGbF9SGMcXMxRAf8w@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
To: kernel test robot <lkp@intel.com>
Cc: linux-hwmon@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174084005213.13423.3010515896888885342@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 15:32, kernel test robot <lkp@intel.com> wrote:
>
> Hi Antheas,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on groeck-staging/hwmon-next]
> [also build test ERROR on sre-power-supply/for-next amd-pstate/linux-next amd-pstate/bleeding-edge rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.14-rc4 next-20250228]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Antheas-Kapenekakis/hwmon-oxp-sensors-Distinguish-the-X1-variants/20250223-003148
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
> patch link:    https://lore.kernel.org/r/20250222161824.172511-12-lkml%40antheas.dev
> patch subject: [PATCH v2 11/12] platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
> config: x86_64-randconfig-078-20250301 (https://download.01.org/0day-ci/archive/20250301/202503012254.EtBZW7gW-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503012254.EtBZW7gW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503012254.EtBZW7gW-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: devm_hwmon_device_register_with_info
>    >>> referenced by oxpec.c:1051 (drivers/platform/x86/oxpec.c:1051)
>    >>>               vmlinux.o:(oxp_platform_probe)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Guess it doesn't merge anymore. I have two other nits I fixed so I was
planning for a V2.

Question for the charge_type ABI. Should we switch to charge_behaviour
since that also allows for autodiscovery?

Antheas

