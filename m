Return-Path: <linux-pm+bounces-18555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9774E9E3DED
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 16:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538562812AC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA920B804;
	Wed,  4 Dec 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4IQ0q8H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E420B1F7;
	Wed,  4 Dec 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325231; cv=none; b=p9y5tITPShmOQS6qbc64fSVpX9eJ0uo2Y66pQQmJTWKEAVLO9oyYNkbS9Twe3DCsS901n5XH+POq5oFbB5NbYhN7TF/8X3cgDblFPJnknaS3K3hPKfd95CN/0MiUBYFwbTRUEM3ii3By0NwwlHYpmk/r+klRmjEfroNMcgIf7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325231; c=relaxed/simple;
	bh=EEf76SgX/3puazt8ufia4uZKilO394GYwACgLeP/Df8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns/YOO+lGL3fL4XOAMKOJuHGe7pd5jirrZxMG2LbbRkE/qhPNzoDXeI5qbKEFBEGcuSW/49//dxtAKw6rkV9igHUur0hwN1Ul7Ao7mO5JIntvEtnqpfwD3PNT8by1v2ixeiJEkLq0M6X1D404j1fyYnzoBsVBdj7fD1Smsi9u2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4IQ0q8H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a10588f3so45357535e9.1;
        Wed, 04 Dec 2024 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733325228; x=1733930028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K67aLAUzSfbUuMMVxrZ7xG6js3aZNsZytWIuEf4fsUo=;
        b=C4IQ0q8HeQT/BKuAjnV4MA+fh/7s4fm00qxOCzdV1zteEXEXuQk+Je0+BnVY25pA7a
         x7eexYzBzXdYUZJn5av4cLh0sSFbsumeQ8wxr+cmclBOeQWpFM17TVIrbfqI75uCGXrm
         w/CuxHljucCS0YzoJI9WBVMcmzqKPJatrtXS6+hSbJApORWk4IR3v27iMzvjCmqU7vIn
         t2a7aI8W0XpZ0rZ4Swc1ejMIFLyoxLC+OtR3LS5wW/mAiea3FYML9L5M1lAgb0as49g2
         LTdk9Kd13eUBoNlnaMsuIcecWf5TX1uLnfSXWnM2wqQpJTAy2N3N3mmbGZBeROm4C/Vp
         7ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733325228; x=1733930028;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K67aLAUzSfbUuMMVxrZ7xG6js3aZNsZytWIuEf4fsUo=;
        b=o59UXcUL8okyEK5wYD2tb1RUgqi3Z8hFGT2iEx8AwdWiueAS2Zn2GEhxg2X+hPu8h/
         wpwL15CJlTbb2hpJ9e9yCc+oCNXChk3crO2DL2vAbwe0zkPkopZAHHYZDXNhpYTlf0oL
         zGQHf1XDWDf/vh71YgwPL2WrROwr+sFm/YiL2S5IG0o9m5X/l04WK93CF0M0uH72SgRC
         RLZ/eB5jK1D0jfKck/paL8P0CAVAx2MHp3Td8j9r1o/nuPKTvq2xEApLIbpYI9DkND7E
         qaQCLreDD9rCNw8qvYyE/KWWJpi+/4vSaSGihSIbF++5lcu5SWYPJYxyPNzTMRcqG1TQ
         XxBg==
X-Forwarded-Encrypted: i=1; AJvYcCWqRYh9ZljQpb5Tq03LxpQdGQnGoI2WviFJ6GkrOk+l/W54fQSVOSqIRIyy381zfQ9WFE9kqKoW2iIx@vger.kernel.org, AJvYcCXTpqQ0+lDveLEv3kDakRah/W3lUVNEa5w8LONQ5HxzfzQXbmiUfkr0FljJJWrxpVdsw+8y6mYO4vE=@vger.kernel.org, AJvYcCXa1tt8IEWP6b2XURceeL9ue9SuvBZXIn6lJfq4KCtPaARX6wJpb2a8ZyBAA+ya74xbpxFjShJbTHIqz154@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUxnHJ2sW5W2wKz2ZvQ0ogBwvvvVKP9nBgi0AHGe3WGDP72aF
	ubn8BsO1ZxN3gIl1eX0gy6Ge+yUQPwPVtZ6bRU1OjHS6YjyH9pwlyISLLw==
X-Gm-Gg: ASbGncs0JPkVesa7ECWE2rSn7mg/BjKS3EfJpR0Xz45hocSjo+uDWf+xxwd0ax3C04v
	SxITgTsy0d7zMhVmo4KAZ6qxaJhvAe9DShP/q0a9+/8b3xsxRR4+icLLhQWHOzhZfY2xHrmAwQf
	mpOC85l5vyxq4G1v2G/YHfTE0NRsG+nWp/BVeuNYSbH3w9zAZ9uCxVEv+ljeL/L75cZB5bMTkzN
	1RUu7XBvqBmZ+WULNwTB6KYPsF9DFqrVYqxPTUdtCP3OA7TAWfvHWiFR3+ov9kASX8RwUL72w3M
	Iq53qw==
X-Google-Smtp-Source: AGHT+IGZWimo8j6jMFRask/atuO/zxTgFDYDzsdxIc9v2gqFWxahTgIfn6oEZjIvWK770r9mpIOd6Q==
X-Received: by 2002:a05:600c:1c1d:b0:434:932b:a44c with SMTP id 5b1f17b1804b1-434d3fe339emr38546645e9.27.1733325227755;
        Wed, 04 Dec 2024 07:13:47 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5288e02sm27431415e9.20.2024.12.04.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:13:47 -0800 (PST)
Message-ID: <675071ab.7b0a0220.183cea.8610@mx.google.com>
X-Google-Original-Message-ID: <Z1Bxp0xQYLa6G0a6@Ansuel-XPS.>
Date: Wed, 4 Dec 2024 16:13:43 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
References: <20241203163158.580-2-ansuelsmth@gmail.com>
 <202412041929.8aCqrGnO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412041929.8aCqrGnO-lkp@intel.com>

On Wed, Dec 04, 2024 at 07:22:41PM +0800, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on rafael-pm/linux-next]
> [also build test ERROR on rafael-pm/bleeding-edge robh/for-next linus/master v6.13-rc1 next-20241203]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-airoha-Add-EN7581-CPUFreq-SMCCC-driver/20241204-113105
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20241203163158.580-2-ansuelsmth%40gmail.com
> patch subject: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
> config: arm-randconfig-003 (https://download.01.org/0day-ci/archive/20241204/202412041929.8aCqrGnO-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041929.8aCqrGnO-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412041929.8aCqrGnO-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/cpufreq/airoha-cpufreq.c:41:34: error: variable has incomplete type 'const struct arm_smccc_1_2_regs'
>       41 |         const struct arm_smccc_1_2_regs args = {
>          |                                         ^
>    drivers/cpufreq/airoha-cpufreq.c:41:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
>       41 |         const struct arm_smccc_1_2_regs args = {
>          |                      ^
> >> drivers/cpufreq/airoha-cpufreq.c:45:28: error: variable has incomplete type 'struct arm_smccc_1_2_regs'
>       45 |         struct arm_smccc_1_2_regs res;
>          |                                   ^
>    drivers/cpufreq/airoha-cpufreq.c:41:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
>       41 |         const struct arm_smccc_1_2_regs args = {
>          |                      ^
> >> drivers/cpufreq/airoha-cpufreq.c:47:2: error: call to undeclared function 'arm_smccc_1_2_smc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       47 |         arm_smccc_1_2_smc(&args, &res);
>          |         ^
>    drivers/cpufreq/airoha-cpufreq.c:81:34: error: variable has incomplete type 'const struct arm_smccc_1_2_regs'
>       81 |         const struct arm_smccc_1_2_regs args = {
>          |                                         ^
>    drivers/cpufreq/airoha-cpufreq.c:81:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
>       81 |         const struct arm_smccc_1_2_regs args = {
>          |                      ^
>    drivers/cpufreq/airoha-cpufreq.c:86:28: error: variable has incomplete type 'struct arm_smccc_1_2_regs'
>       86 |         struct arm_smccc_1_2_regs res;
>          |                                   ^
>    drivers/cpufreq/airoha-cpufreq.c:81:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
>       81 |         const struct arm_smccc_1_2_regs args = {
>          |                      ^
>    drivers/cpufreq/airoha-cpufreq.c:88:2: error: call to undeclared function 'arm_smccc_1_2_smc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       88 |         arm_smccc_1_2_smc(&args, &res);
>          |         ^
>    6 errors generated.
> 
> 
> vim +41 drivers/cpufreq/airoha-cpufreq.c
> 
>     37	
>     38	static unsigned long airoha_cpufreq_clk_get(struct clk_hw *hw,
>     39						    unsigned long parent_rate)
>     40	{
>   > 41		const struct arm_smccc_1_2_regs args = {
>     42			.a0 = AIROHA_SIP_AVS_HANDLE,
>     43			.a1 = AIROHA_AVS_OP_GET_FREQ,
>     44		};
>   > 45		struct arm_smccc_1_2_regs res;
>     46	
>   > 47		arm_smccc_1_2_smc(&args, &res);
>     48	
>     49		/* SMCCC returns freq in MHz */
>     50		return (int)(res.a0 * 1000 * 1000);
>     51	}
>     52	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

False positive or better say my error in the kconfig depends logic

This driver REQUIRE ARM64 bit for smccc and the target SoC is 64bit
only. The randconfig catch a situation with ARCH_AIROHA and 32bit.

-- 
	Ansuel

