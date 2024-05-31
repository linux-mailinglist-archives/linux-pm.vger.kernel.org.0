Return-Path: <linux-pm+bounces-8491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C798D6C7F
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 00:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C97D1F2B0DE
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 22:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411A81ABB;
	Fri, 31 May 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K36AUn7r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B1823A3
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194471; cv=none; b=HLkhS9LZPk2nEEbn/MKg4kykS2ttnpK6zWGlOTYu2C6LOwUbd2loCNURSyZWjl0BKja8CGAXwoTTGxhFHMZC+LrkpYTPXecO8fE+xHKiDWNjuE9CaU1thaQyz4SnPtAznzqzNRfcjtBNWJCrKDOllfNL5soDiK750kMLp9jA11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194471; c=relaxed/simple;
	bh=47zVUZ6ZaDmbQZcGsG2b1W9jbTU6fzVCznAMQJ39GtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMp0FiVrbtR8+U22+v4UgQEBDDOU7BSFa27pMhwHNZ67JwYja7MZkIVq93L1UGvaN2uKivoZ7gaqCsPutB9y+ECvKyS/nWYyNfN1gmcP7YovIaAJWGC0q0yYODtJE/3KgqEZCMZGQ55gzl8lm+aQRAONEJi+684n3iwFe9NmpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K36AUn7r; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717194470; x=1748730470;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=47zVUZ6ZaDmbQZcGsG2b1W9jbTU6fzVCznAMQJ39GtY=;
  b=K36AUn7rH2JDq3rExBilODz8+lAlg+AdcOjsNl94SPRVyP4xeQChu29I
   oayTKFbE141SL076YCpHclJamgNfgIm/bgQuTUQwQyED3CFWLIknAM+Ae
   MlrBkPSQFHvftwVmEBZd063cevL6fBBP5MV+hBt9fpgtmfhd4JsbYTNIr
   rmPPTFZHZndxN307cf+MOE57MRZXuuNaJ6An+OE81umP+y9Cv4r2aP/Uj
   OBgr4mqZmp8LFy6kAmAL/XfHvo3c63bHH9t9I5IaiaAwPITsBYAs/SFp6
   tkWfoBdal7zc7Dx0grrWI7CdqRtRNlCTyAep4UNsf7myCjR8D5O///twA
   Q==;
X-CSE-ConnectionGUID: KdwCGzT1QNCBDMQL0/8x7A==
X-CSE-MsgGUID: UhCgztoiQf2VWU+p2oQ+6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="16710283"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="16710283"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:27:47 -0700
X-CSE-ConnectionGUID: w2AQoiNLTOG2vfRCdTlNJw==
X-CSE-MsgGUID: 9rdVYiS6T+ah4wLZ67isjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36878328"
Received: from kpadmini-mobl1.gar.corp.intel.com ([10.215.123.86])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:27:44 -0700
Message-ID: <50b02adac1e8209c11a5fe1ed1b77e4d57ab11b1.camel@linux.intel.com>
Subject: Re: intel_pstate_get_hwp_cap on wrong CPU
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len
	Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Viresh Kumar
	 <viresh.kumar@linaro.org>
Date: Fri, 31 May 2024 15:27:38 -0700
In-Reply-To: <20240531140140.pfKOWdB-@linutronix.de>
References: <20240529155740.Hq2Hw7be@linutronix.de>
	 <ca47b6f812175ea60f6ad615274223aa7fee295d.camel@linux.intel.com>
	 <20240531110200.CtBSN_p4@linutronix.de>
	 <3eaf90b63edccb3317968101040510c91b5b2f4e.camel@linux.intel.com>
	 <20240531140140.pfKOWdB-@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2024-05-31 at 16:01 +0200, Sebastian Andrzej Siewior wrote:
> On 2024-05-31 04:56:04 [-0700], srinivas pandruvada wrote:
> > > Would you mind letting
> > > =C2=A0 /sys/devices/system/cpu/intel_pstate/num_pstates
> > >=20
> > > reporting something sane? Not 4294967285 but 0 for instance?
> > > Would
> > > that
> > > make sense?
> > >=20
> > It should be some good value, usually less than 50. Do you see this
> > high number without even triggering condition, which caused
> > warning?
>=20
> Nope, without the error I see 22. I think this went "-EIO + -EIO -1"
> which ended up as what I reported by chance. Never mind then.
>=20
> > In your system, firmware changed performance notifying via ACPI.
> > That
> > method is deprecated for a while. You are using Haswell, which has
> > this
> > support. But deprecated from Skylake.
>=20
> Okay. Anything I should change?
You can't on these models.

>=20
> > > Did Sebastian _Reichel_ report it, too?
> > My mistake. I picked up wrong Sebastian. Sorry.
>=20
> Ah okay. Then
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> because it does not do read the MSR in the code path I reported.
>=20
Thanks. I will post the patch to the mailing list with the correction.

-Srinivas

> > Thanks,
> > Srinivas
> Sebastian
>=20


