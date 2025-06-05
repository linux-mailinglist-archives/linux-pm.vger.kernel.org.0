Return-Path: <linux-pm+bounces-28163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D28ACF552
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EEE1890310
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A02750EA;
	Thu,  5 Jun 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VW38q1U0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1761E519;
	Thu,  5 Jun 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144328; cv=none; b=AmMFS83DeoSrZ1oQiObwJh16KfC3VxZ/f7RkhP2p4NVNoYnOnSpLT74ef7ytqW7tMJhsm7oldy1fqH2HZR7DLRXa32A7Fx/oqxCE+v9qHyfdjfVBUvxybq9b7IsmgI9P7KlLfSW8+uZQ7K86TbDftCFvdxp5hToYjpqO8idbywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144328; c=relaxed/simple;
	bh=5Yl5mCYxrczLodJ0pTPkcFCpM2H4dD6dZ5cU19KMeyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBgUwjrVUIfkaumeDtNIFazxSHYHllTW4I10Ey4rAYL/p9qb2WHHkhxngqrBLE89xcA47QqXBQQXzFQ+pT7dlvtkBzkMihfDsTlSLb73kjDw1Oox8oUGngpIyJk+kZ8Hb/ELTEAZ+L+Hn8oigUE3XjGWpnXPz0nbQ+5fTk66llc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VW38q1U0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749144328; x=1780680328;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5Yl5mCYxrczLodJ0pTPkcFCpM2H4dD6dZ5cU19KMeyM=;
  b=VW38q1U0lEOTejoNTG/5BeId1K26r2SNb5CaGmiTPixFYfa0URXQPoHo
   eClF0fE/zMJd8ak8EzPK46j5qxEVJVT9kgMcwrvw98pdP031UK5J5punM
   paM6kYHoHlI/JL0anD0GqXm3MRuzoHWslrOOHyk1G57v2xlaCesZ7mn5H
   G6Q9yg4qb2cGojiTj3ntR1WYpiIoXjerckqC/CUamVFHAsYsL082Weyan
   GOgcD8SXQ1VQM3dyKUTW9kSH6R3q3v55onSN/UDmJBpEO55FnNmI23HhL
   3ojhXUGfP0K/OdMTdRvN81cLzwcnbuUbI7UBPoTZHaGSnW3/VW3YTZKMl
   A==;
X-CSE-ConnectionGUID: cOVoWkJSQUSKpKQH7SSmOQ==
X-CSE-MsgGUID: z2AV60C1Tn2hE9zS8QB3Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51134671"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="51134671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:25:27 -0700
X-CSE-ConnectionGUID: +QonGZtsRx+Ju9/3s/IE8g==
X-CSE-MsgGUID: iG+kP28qTMWQPy0uhoupGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="176531907"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.222.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:25:27 -0700
Message-ID: <5a0dc3858c802a5d6247424529377c6dbfd450ca.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] thermal: intel: int340x: Add performance control
 for platform temperature control
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	 <lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>, 
 "daniel.lezcano@linaro.org"
	 <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Jun 2025 10:25:25 -0700
In-Reply-To: <f33e302aac482860eebf5e5f45a44df77455512c.camel@intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
	 <f33e302aac482860eebf5e5f45a44df77455512c.camel@intel.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 03:06 +0000, Zhang, Rui wrote:
> On Wed, 2025-06-04 at 13:35 -0700, Srinivas Pandruvada wrote:
> > Add additional attribute to control performance of platform
> > temperature
> > control feature. Two attributes are added:
> >=20
> > gain: 0-7 levels, with 0 being most aggressive.
> > 	7 =E2=80=93 graceful, favors performance at the expense of
> > temperature
> > 	overshoots
> > 	0 =E2=80=93 aggressive, favors tight regulation over performance
>=20
> By reading this, I know that setting "pts_0_control/gain" to a larger
> value means less aggressive ptc control.
>=20
> But what does "gain" mean here?
This is the input to the algorithm on how much performance gain is
allowed to be in acceptable range for trip violation. May be call
performance levels instead. I am using the same term as in the spec.

Thanks,
Srinivas

>=20
> May be my English problem, I'm trying hard to understand this, but it
> is
> still a bit confusing to me.
>=20
> thanks,
> rui

