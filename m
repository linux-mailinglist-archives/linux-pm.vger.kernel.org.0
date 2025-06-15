Return-Path: <linux-pm+bounces-28735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24BADA421
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 23:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9036B16AC27
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DE27E1C6;
	Sun, 15 Jun 2025 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWCcHxZ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA1189B84
	for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750022293; cv=none; b=nmkgiHb++HgZSxoNkcCAvTZaxCFwZzRnKnf7tsK9XYPLxdnhCrU4+5RWjCyZ+7z+gTT2H9I42ERp+JjJXkNqro9eh8gxoZBfjifAogRv4pTLobyo3P5QRAFIXhNX+ReEBN1CvL68mUyC4NefxD89nKkJ3b3Nuti8nY/Yar+pVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750022293; c=relaxed/simple;
	bh=Ky35e52EIfbhV8BPsYNhSX7ybhbD4Ajlg+RXV253gFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGGsSVyKvWJ7DR36b4bm88qFq+a95J6g7bD3fGEccdugvgo1WJt9f4B8gaBWSbWQAkB+Kso+OYhnCiXZkU91ehcMIYbmUd2JFeQihbkrprOf+ncaeqlborkud9zKGfwvm8hMO+XDLnN3lTAa3Lm+rJ46weKEfFT3ZDW41V05wuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWCcHxZ8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47e9fea29easo363381cf.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750022290; x=1750627090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kbXAdW4yCyx3+5ff6ebsyeCYa7wKjRonHdL8V4+kCCc=;
        b=YWCcHxZ8atzCI5ecWCHOUeIwWx3aPtslb7EAS7U5v6jNEQ9YzfN/I9T70B/OWDku+H
         IMjB9Mue4tTNvBxZEIFh1mU+VUsslQG21fatGbOSIN+SdaZbt9kCYysMPHtdwSSUXErF
         hy9Rs0gGQjMHHUIL8V0EwJfEq5plS3P5IuLsDhBHtTsU3VVC3eICZqJPumS7+ORejsuB
         LGDUXU57IpTkmeM76GCelUlmUFs3EjSL+MA1aFMzQS2NN8mklz73Z5J2+GEVPSEwTcA7
         DxBa9xKacsxMI9xwG/kpP0QocTWx58LtfLnlLBQrwBOPSul7iHAOMtj1xIdeBQHcVxBh
         /+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750022290; x=1750627090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbXAdW4yCyx3+5ff6ebsyeCYa7wKjRonHdL8V4+kCCc=;
        b=WRa+zvWFzsRp0kYMflEzn1ang3CEBeYc61KwmPwXSlT4W9HACDW6uwtpNfVZVYrvR/
         WLirreQaQSHYTChv7gv6zL9jZX3pI7P8BY4j/FUSIzkVicUDidZRocNJnKKtWbK/92u3
         KPQVhJzgYkolHIBC/a6um014UYItEVbq9d5H+9srxvXOoFlQghDcZ4o4C76Uxg2EZscv
         pYNf6t2MJVHGOtGCgiUbXN0RvGle592vcxGY15oJpTtDCU3AAnfnmDEJiaqQfGVAsea+
         dMPHxEmmln4O8QCQGZ9z6qhzJM0z9tt8pWWGcdayzzzDaCTo69aIADJWwNd/caTG8nzN
         uqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoK+6y6DHJIV9ClPx+PtKh/2LXJhnGrC2WfSJIDhdmsezMnXhJQx3WHFo5hltrsC/zNePJoByMTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZ/9OVWL1VgReZM1d1x514PNufGfnSVkLV8k4sAPkezF5XRa2
	XiusPbdyT/7A+cGSuVVWKGdmDgjNCEYg2IaEpMmWBoUT75lT+URxlLyGi9CYUhySbuCycgaURUX
	OIYyT00fRZehZTkIIu1oYhKgwIJmQ9ig68dqDOU8/
X-Gm-Gg: ASbGncvzR5H44GvrCr2UY+Pfb/cHJuhgfK8/CCcsXrrtHF9t/Qkrjygeei1fMvMbwFy
	ctXiDg1KwUPwuHwFE54wAStliLMhKZhM6chdfqNMOd4Q9A7ePl+HvIwbiU+Ecx+MYWuvm5U7/Al
	tmlQXwFmmgD2n+ZlmTFzvt8wapzQ0TR6nvpT8gTWHU8oKSlsrJ367j
X-Google-Smtp-Source: AGHT+IHyI/giLHDVc/7oPe4Y25Gt2jV0dsA6547ZDZPHEOCQg32XugU1twVIDGD6RTN+indIRIvFdvKPkx2AFVBIUl4=
X-Received: by 2002:a05:622a:14:b0:4a5:9af6:8f84 with SMTP id
 d75a77b69052e-4a73d63d94bmr3695771cf.14.1750022289596; Sun, 15 Jun 2025
 14:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614003601.1600784-1-pmalani@google.com> <202506152245.BJAubGbp-lkp@intel.com>
In-Reply-To: <202506152245.BJAubGbp-lkp@intel.com>
From: Prashant Malani <pmalani@google.com>
Date: Sun, 15 Jun 2025 14:17:57 -0700
X-Gm-Features: AX0GCFuTWLHc2ZNlsl7lAd0ZY_hlZfWYDoaHvW8UG6RUWnh-8TbmHsZbKEHTaNY
Message-ID: <CAFivqmL4BPX3seUykFiSpehME13OdwKBoefnxw=owJyvggw30Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Dont read counters for idle CPUs
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Jun 2025 at 07:28, kernel test robot <lkp@intel.com> wrote:
>
> Hi Prashant,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on rafael-pm/linux-next]
> [also build test ERROR on rafael-pm/bleeding-edge linus/master v6.16-rc1 next-20250613]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Prashant-Malani/cpufreq-CPPC-Dont-read-counters-for-idle-CPUs/20250614-083659
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20250614003601.1600784-1-pmalani%40google.com
> patch subject: [PATCH] cpufreq: CPPC: Dont read counters for idle CPUs
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20250615/202506152245.BJAubGbp-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250615/202506152245.BJAubGbp-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506152245.BJAubGbp-lkp@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "idle_cpu" [drivers/cpufreq/cppc_cpufreq.ko] undefined!

Looks like my compilation .config included the header implicitly, but
it got missed here.
I'll add it in v2, once there is consensus on this change.

Best regards,

