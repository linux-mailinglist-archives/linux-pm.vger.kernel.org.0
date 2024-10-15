Return-Path: <linux-pm+bounces-15637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BCF99DCFC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 05:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7018B20E97
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 03:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16A16EB5D;
	Tue, 15 Oct 2024 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lj6S8VVR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C546B8;
	Tue, 15 Oct 2024 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963998; cv=none; b=iWW/HIvdD5epifiTCMIwN6ZRgoESKUY7XC34pxWFmgYB9jmUffFxhgxC8wY9QN80I2TvLJ3qasNQu30aGGAlfj9x5PwbleUwitpL3xYHGGATyvGgVIyQGHmT7Q835VttEBuf1Cz5I8jHH1/vjE1/JGI1QSOuEGv/CPpfdJCee0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963998; c=relaxed/simple;
	bh=VhP4ufTp43pJg/B1YzAD8L/O5ZhgPE90KANbJg7mQno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVmBBOqjoWrCLEsINyPAniBcLZXfAS8EXPcArVLM6HJzQRMurUto8yjxp3ZHecgOkBNW2NPl1AgDTS1x3OfUHK6SmS6/lrEtvuVIQg4cg5NCubPVIXK3QT8/KdAcxfangze7eAhgftVRZhg1gQC0uMX7VHmDPuOu2yKHZXXNn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lj6S8VVR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728963997; x=1760499997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VhP4ufTp43pJg/B1YzAD8L/O5ZhgPE90KANbJg7mQno=;
  b=lj6S8VVRdFFlUF7DscBtUFidf+3J41dgXnmXrGdNT7S2LFC/Yq4nvuOY
   1EbqYBpXzomDa/KWYuNPugK6Zhr3hr5kJ6liSiO3EJ0LqU49kRU9qhMQN
   n9Lbx+4iRLsTVUSYQDDtuqkTYGCPO0t5O1pHtiw+ZKzv2qfvTbG5rc8uS
   qUnjipaEms/oc+2CL9fdAFfUeqA1card6bAhOhC98BTO0veJtmCqgOicB
   8B7kYEuGe5/7tTIaiCvQbjRe/qEt95T8iGDoIONjZzrKZ2gxGMD8+JmDb
   l3I0cttwJe8WE6fbVfG9XL5JmpiaVSReZNeOrTurK4JZvRZUdJ11eAvTb
   Q==;
X-CSE-ConnectionGUID: zz9aVldMS7W5QtnNsSM5hQ==
X-CSE-MsgGUID: ezzSmEbtSCiPO7RRgiFp6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32030702"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32030702"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:46:36 -0700
X-CSE-ConnectionGUID: bwm9j0/VTpKek/bv8SBTww==
X-CSE-MsgGUID: xHSe1yZgSUWFVMsljU7kNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82789775"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:46:36 -0700
Date: Mon, 14 Oct 2024 20:52:33 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Message-ID: <20241015035233.GA28522@ranerica-svr.sc.intel.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010193705.10362-6-mario.limonciello@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Oct 10, 2024 at 02:36:57PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
> 
> There are two CPU core types defined: `Classic Core` and `Dense Core`.
> "Classic" cores are the standard performance cores, while "Dense" cores
> are optimized for area and efficiency.
> 
> Heterogeneous compute refers to CPU implementations that are comprised
> of more than one architectural class, each with two capabilities. This
> means each CPU reports two separate capabilities: "perf" and "eff".
> 
> Each capability lists all core ranking numbers between 0 and 255, where
> a higher number represents a higher capability.
> 
> Heterogeneous systems can also extend to more than two architectural
> classes.
> 
> The purpose of the scheduling feedback mechanism is to provide information
> to the operating system scheduler in real time, allowing the scheduler to
> direct threads to the optimal core during task scheduling.
> 
> All core ranking data are provided by the BIOS via a shared memory ranking
> table, which the driver reads and uses to update core capabilities to the
> scheduler. When the hardware updates the table, it generates a platform
> interrupt to notify the OS to read the new ranking table.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

I tried to find the HFI details on the documents in this "bug" but I could
not find them. What document in specific could I look at?

Thanks and BR,
Ricardo

