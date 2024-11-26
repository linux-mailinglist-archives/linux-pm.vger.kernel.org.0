Return-Path: <linux-pm+bounces-18123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC089D96E7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7656E281F2A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12162194AE2;
	Tue, 26 Nov 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHfzsqTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435C1A260;
	Tue, 26 Nov 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622619; cv=none; b=hAuEzulDdyAnMqLlKBQiNvFQIE5qewqT2eFNPXtNJ/B8ObvH4Y5LfBOeY7VS8YgscAu4VPLLTWxOFs/jioEfkA4zsY3HZr7d1tAQjoMWF2FwO04NSeF33vfUPqD+H/ybQhOQ4B5ljPwLw9Z79v64S2exMaelWQqeP+eC7wbiC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622619; c=relaxed/simple;
	bh=KQ2Qwf/WUtt57GjnAKuyeqWQyd7lqHYahiwwpQgoLEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT/A9uYQ0fc1T+jHAG7gLpRNoKN0vhMbcUKehG/XWBPVMoDmFkPTM91W4RzJEy2aLw+SrUWnrr4IcMcc8col8P9uQM0Sqc1cBtOadWj2fc3swjaZ2gnV99VUGUeFfQA7tI79Cq36kjr8vt8wDD2TeQU4t9C+NERZr9OGDHgXCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHfzsqTc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732622618; x=1764158618;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KQ2Qwf/WUtt57GjnAKuyeqWQyd7lqHYahiwwpQgoLEQ=;
  b=VHfzsqTcYLxlkqFUgExiCJt8w6+dFwCYtHrtEHpa34ijirpH+8peWcZz
   gJdQClGbMKWLj3bTPX34EN05QjGxfNS5DiyEUT13syZ89rFzvxNw9gT8D
   iIN4xP55U8HV34+JSgXzE16Ove73dP9piETSF45GdBmXIQe4i8YoLy/8F
   5Bzc2F6QrtW6n0vVs//3Pl+RHnfgK3avyynSH/ZcqBKWu0KU0KdZ6l3/4
   VVWXA9prA905+X6ixoj6aBhkjAC2eQnNLk8btuVinW3FMrrFpWzk4290i
   pkx7uvqJE8dZtSY4vJ4rdbY99VfSfbxvkhL5cLR2ChUCwQEaQjuj2mKrL
   g==;
X-CSE-ConnectionGUID: nNl7fX8SRh621NsbmkUIBw==
X-CSE-MsgGUID: slOb+XF6QRaD0O1JWiLMRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="35636138"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="35636138"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 04:03:37 -0800
X-CSE-ConnectionGUID: xrVdJ5hVQAasD3/RTHm3vA==
X-CSE-MsgGUID: UEOyiiVeSgix3d0nUao2cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="91487110"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.245.172]) ([10.245.245.172])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 04:03:33 -0800
Message-ID: <92be3895-8c12-4566-ad61-a81925d14c46@linux.intel.com>
Date: Tue, 26 Nov 2024 13:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 7/8] acpi_idle: Add FFH cstate handling
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-8-patryk.wlazlyn@linux.intel.com>
 <Z0SUU+dEeF5NqNBM@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <Z0SUU+dEeF5NqNBM@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> The patch looks good to me. But this needs a more detailed changelog.

Yup, sure. Thanks!


