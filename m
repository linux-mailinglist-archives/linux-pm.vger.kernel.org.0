Return-Path: <linux-pm+bounces-9398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913AA90BFEC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 01:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57B31C2114C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 23:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CA19925A;
	Mon, 17 Jun 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFEztkGX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD786288BD;
	Mon, 17 Jun 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668347; cv=none; b=cN3oqUbhOCMTXhkQiBsxTIG4DVGAi47L7uq/cdQyL3yUjTim/mMM1mHj9e8a4IoV2Nx7Tu0nNzUBIY+esvDiIwBm0e+7Q8c9ANxFtsjM8K8dADflS/BKVe+j4J8bK1akSgielk5EkRxdnl5CJEHHMUT/PTPNz414wuyivrigrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668347; c=relaxed/simple;
	bh=BXYN8PEnCgS9PPW8UWd2dWyU/Wo/+xLaycJ4i+ZgVgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7UAdLMAbSCwPLPfDp4rIjrHqJXqXZkCSP9o+UNebresSpEcuDz5l3F17jlsfS+UxQN+/3Ps9Wu0jQu5VMXf9V+yfZw7qKoslkItmvT0ZKFiskIy+g1MMEX99nL0aKXwSYnyih+35NNc+xsepgbcDEAyrubq0tePL5gPl9WJ3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFEztkGX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718668346; x=1750204346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BXYN8PEnCgS9PPW8UWd2dWyU/Wo/+xLaycJ4i+ZgVgo=;
  b=PFEztkGXex1ZpFp4ZvxvE00fWAm9AwOMYG+7DhHV/EhxPD4RFFsKWpOO
   hi7INpy/XYTJShzSrtEsng6Iqoj1f8moc/VjCpP/iEoNNErMxKFWbQMk4
   KF0AuTInykvn63pSGolb/ACgaTLiZBaRwh0CMKR6Bo30K+Z3m542T7rVg
   piwqSxO70JzSo9T5z38UHx+inPGNLjQ0OEDmGZ+9bxHcOnfxfK8JI4Ios
   zGXmPakzgAOCScI5dpDXm9csd/IK2mYMGZ8CIXW8vKzb2/hF+fgMpizeq
   7dZt7QogwtuChtjeOxIMZAAzcgoOmqu7bRbkX5TKRfK7pUKc9pF+8QAfB
   w==;
X-CSE-ConnectionGUID: gz9eHDTLT3a8K69yFfBHmw==
X-CSE-MsgGUID: ukoY2wkZRdq7b2WbPKAULA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15358542"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15358542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 16:52:24 -0700
X-CSE-ConnectionGUID: 1CURPBuRTySoCth8QljYiA==
X-CSE-MsgGUID: plgCdRqUSg+9pEANBF55bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41829980"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 16:52:24 -0700
Date: Mon, 17 Jun 2024 16:52:16 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 8/9] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240617235216.qqvfh2nvffuh7oot@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-8-b88998c01e76@linux.intel.com>
 <fb789f0a-0c80-49f3-ab7e-d22fc2793a49@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb789f0a-0c80-49f3-ab7e-d22fc2793a49@intel.com>

On Mon, Jun 17, 2024 at 07:13:15AM -0700, Dave Hansen wrote:
> On 6/17/24 02:12, Pawan Gupta wrote:
> > No functional change.
> 
> It would make me feel a *lot* better if you also dumped the before and
> after binaries and made sure they're identical.

Verified that they are identical. Adding this dump to the changelog:

$ size vmlinux.before vmlinux.after
text		data		bss		dec		hex	filename
33128289        23039446        19767300        75935035        486ad3b vmlinux.before
33128289        23039446        19767300        75935035        486ad3b vmlinux.after

