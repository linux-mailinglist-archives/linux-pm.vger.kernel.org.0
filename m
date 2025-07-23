Return-Path: <linux-pm+bounces-31330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF373B0F147
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DEC7ABB83
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409442E49B2;
	Wed, 23 Jul 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLKt3myD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F02E4990;
	Wed, 23 Jul 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270509; cv=none; b=Ud626FT5DwDzPvp5Y/KSsdfrWZ+poJrcJ+QNYkb5KGjaQ/BIKirQNsjfta1vyzjlSZ+L5XMwG4IA/DvDIfAVPZwW+KK2QD1YSn7y5hL/LOjKQQuEHBnehHJayFv5EgG+OLdlyQT6kbS5eHg28aMpZK6C40jFMAs9BrbpPhAfcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270509; c=relaxed/simple;
	bh=wWXh0UC6IdNRuDVc9X1iR+0uK1NLMaVjxnOIY9P0mSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBYfbc2ZCS+4xaq0hoeabgd6f6q3Je5RVJY9Lw7NqJ8U8NjRVH07RNIMK4UC19HlLWDDVeDKphvbEbkToBK2Ux71kYtcQL6I9y36TH6byAbWDzz2HgTWeD+d/dqxmCAOScn8Bz28lGorIhTc8w573OR5KdH36gMXPQ1oOrnFgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLKt3myD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753270508; x=1784806508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wWXh0UC6IdNRuDVc9X1iR+0uK1NLMaVjxnOIY9P0mSI=;
  b=eLKt3myDMw3oStJuZE4r04S8QNzt2rnD1YbjPU4E3srAYkiyD0fVP5RI
   CmhOvO0nqVuxO1cnSJdnmtIbU6UPR8ToTQlQpEJsrQ5+z5LiFWlX2628Q
   wiBU++nERoz1lXb833Angg4altN/ENFbPwDhZx3H4t76WhosKs2PaARdF
   8pHUZ/E7+bVc4Dei88YW3MUn+59se171yCBDKlj37ALXFrdqHMCmPCPga
   PjX101V8AUruV7Xt8BH4sHjqUCd/bpX5R+bJCUMCkm72F1jdJ9sfhJ5/d
   nBB786U0xW75Oa+RMQ4S3OME7nf+g07lyLb0y/bh5T6mK7JNNobwvbKgs
   Q==;
X-CSE-ConnectionGUID: z9tYCeIKSBSpaFwevxPSWQ==
X-CSE-MsgGUID: clWbnSc5SPeF/NKXyCmYHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55504992"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55504992"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 04:35:08 -0700
X-CSE-ConnectionGUID: 2DtL8MyBSAm153MFR3SZLg==
X-CSE-MsgGUID: Fk1rxN0GR92dPuKkfU9dhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164892401"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jul 2025 04:35:02 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueXkS-000JJv-13;
	Wed, 23 Jul 2025 11:35:00 +0000
Date: Wed, 23 Jul 2025 19:34:59 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konradybcio@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
Message-ID: <202507231918.JGWa9fgH-lkp@intel.com>
References: <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>

Hi Konrad,

kernel test robot noticed the following build errors:

[auto build test ERROR on 05adbee3ad528100ab0285c15c91100e19e10138]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/rust-Add-initial-interconnect-framework-abstractions/20250723-051723
base:   05adbee3ad528100ab0285c15c91100e19e10138
patch link:    https://lore.kernel.org/r/20250722-topic-icc_rs-v1-1-9da731c14603%40oss.qualcomm.com
patch subject: [PATCH 1/2] rust: Add initial interconnect framework abstractions
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250723/202507231918.JGWa9fgH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507231918.JGWa9fgH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507231918.JGWa9fgH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0412]: cannot find type `IccPath` in this scope
   --> rust/kernel/icc.rs:222:22
   |
   222 | unsafe impl Send for IccPath {}
   |                      ^^^^^^^ not found in this scope

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

