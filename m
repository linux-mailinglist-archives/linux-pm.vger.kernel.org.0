Return-Path: <linux-pm+bounces-22882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E7A43E51
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31BD4437D0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7520B21B;
	Tue, 25 Feb 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdcQkwlW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDE15B980;
	Tue, 25 Feb 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484214; cv=none; b=k6S9bB4bnn4zFndKMscChX6835JDxyMLTg0dQSf3k4cb4zF/1an46vGJY67Z4PX7EhJ240ZU69kOGqHqmvNoMjIoUHTRRi9c1YvBpsZjYuoqKU/3ejhmcz4FUikfrlC2BfkMUtO9O/O9lq767VohJlmm7qJlTjs3L9kQl720nAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484214; c=relaxed/simple;
	bh=UxEOdwg0ihDoq4aqItGrjjobZcNx/KJtRnB5kORZoJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOn/eglwxKU0N67UWa7mK0bKPQIfO04weobjaxDnKG/IoqonzR1HSXnV5+6HvTk7Pm0nTD4P87kY0LEn1QJemkhpJsiMfLHB8ExVepNMvTToOWh63wS1WEMr21kFhHcviO/LRnqH4wHXIPCOba2H8Nr76mq5aqaNtsYevaicIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdcQkwlW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740484212; x=1772020212;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UxEOdwg0ihDoq4aqItGrjjobZcNx/KJtRnB5kORZoJ8=;
  b=TdcQkwlWUIX4Y5BvZeljVEcrAU0OnZcE/HXOWAny1bPljIE6CF1PTd6a
   jqxzRPOABwFpnmvXa9uvgbPyjgBAb6i5iyX51mWGSYaoSAlZPWoIyX3Nr
   9jBD2Q7fFgmqqC6HiA2Hp9Y/otpFgh5hIhAZ6yxMOfi5ktYe0Z/VmuF8U
   sA8Da8S+1deSscUYmFPHf38peXYeAmoW0igeaCB76Nr8T4jMI3cujAtTn
   ydK8x/onC2D0zfna2M9x8v52dDNcM99EQYsq9miXTFjSFygdaEP5SoqXi
   T8MtTLQT3eP2b3Lj2md8m78GsosTmGjlZOx/urVwZGSz+y7w9jXWW3HXZ
   Q==;
X-CSE-ConnectionGUID: msipkubiS/y4WBbFGfmPag==
X-CSE-MsgGUID: QSuhhlQnSkmukogHQfiDNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44109810"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44109810"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:50:11 -0800
X-CSE-ConnectionGUID: X9uOLBsgRPmzoEzQLs4odA==
X-CSE-MsgGUID: clXZvq46Siynv1mc20Bw3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121463642"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:50:11 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id CD69A20B5713;
	Tue, 25 Feb 2025 03:50:09 -0800 (PST)
Message-ID: <9446c26ad0a640b9f65ac8630f7878e76fe23c3c.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpuidle: intel_idle: Update MAINTAINERS
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
 "Rafael J. Wysocki"
	 <rjw@rjwysocki.net>
Date: Tue, 25 Feb 2025 13:50:08 +0200
In-Reply-To: <CAJZ5v0goH0unRRuQNCKC8WYRndsSenJaVJOYU64COYHocVE7ig@mail.gmail.com>
References: <12621866.O9o76ZdvQC@rjwysocki.net>
	 <CAJZ5v0goH0unRRuQNCKC8WYRndsSenJaVJOYU64COYHocVE7ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 12:41 +0100, Rafael J. Wysocki wrote:
> > v1 -> v2:
> > =C2=A0=C2=A0=C2=A0 * Add an alternative address for Artem and change hi=
s role to M.
> > =C2=A0=C2=A0=C2=A0 * Change the development git tree link.
>=20
> I am assuming no objections.

Oh, yes, thanks!

