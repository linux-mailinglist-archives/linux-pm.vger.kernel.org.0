Return-Path: <linux-pm+bounces-3851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD0852721
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 02:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E641C25C10
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0A0524F;
	Tue, 13 Feb 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjJ64ztY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31F8813;
	Tue, 13 Feb 2024 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789176; cv=none; b=baMQkl/MJrtczDrF3KUIYtCC4R9UmD5A7Rm02FEjyVsPxIMjelUIo4Vex7yzyoEBw4Fa4jc3txfk0ismTL2lZg1OGXAwwCPgiiKLS8cArgEdWjQkYsMIx+aOwv3PPSCghKY2NdTkC8sYE8FjEh0GMkT1hhLndpNs4QWjsNIKaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789176; c=relaxed/simple;
	bh=5e+FWLG2IXO35VEWTCysOoFyyPdiYVsPVIzewBHNQnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSpV3YfZvPpjyvmzXa6ArLCW+EgGooi5bzuFEqv5e/ADm3sqyCaRJOvW0xOwTLPikeriUjIvtQRmGP6lhJmy7WoCYtxIC71dYijL7ipiPJ+rWps24cqdcPFqmbREyT7YzBameQrLL0CPCO0MhEzq14k7XJmWDr8eKrCyRg6RjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjJ64ztY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707789175; x=1739325175;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5e+FWLG2IXO35VEWTCysOoFyyPdiYVsPVIzewBHNQnU=;
  b=RjJ64ztYCqUOOoPDug/UswDWzZM5VDnocirUEh/LJD0Y69ZdOepVhT0d
   zhZC0KFqFImFi3OhmEG4q9R4TxMoN5N/wZtZjUTFcMUjrS+AVDCnbXfXn
   TVIpBUVTJDufwmr5NFq1w3BK67SxChQvytu8XkuMsPAB/yTrzN6YNn6TW
   OWaKA/PDoNo9c4a3R5ckStTbe7CQm6VGhwzjACUnHSEgalMkC4J4lQpRd
   IA8jgI6qtJN9WiL+Gkr1pZ663V46oNi7c+85Q5H+z/UmnAOXggveMtd8C
   BtZgRyj3O2pz2xBEYN1GIyhB0RZqFdeMGjhOd4sW6i2fOM4iiThrxM8L6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1939834"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1939834"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:52:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="33843360"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:52:54 -0800
Message-ID: <22a264118ebe7194cf43a5d7e1d61417feff8534.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/3] genetlink: Add per family bind/unbind callbacks
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Stanislaw Gruszka
	 <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,  Jiri Pirko
 <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, Florian
 Westphal <fw@strlen.de>,  netdev@vger.kernel.org
Date: Mon, 12 Feb 2024 17:52:53 -0800
In-Reply-To: <20240212170700.4eda9c03@kernel.org>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
	 <20240212161615.161935-2-stanislaw.gruszka@linux.intel.com>
	 <20240212170700.4eda9c03@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 17:07 -0800, Jakub Kicinski wrote:
> On Mon, 12 Feb 2024 17:16:13 +0100 Stanislaw Gruszka wrote:
> > Add genetlink family bind()/unbind() callbacks when adding/removing
> > multicast group to/from netlink client socket via setsockopt() or
> > bind() syscall.
> >=20
> > They can be used to track if consumers of netlink multicast
> > messages
> > emerge or disappear. Thus, a client implementing callbacks, can now
> > send events only when there are active consumers, preventing
> > unnecessary
> > work when none exist.
> >=20
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Stanislaw Gruszka
> > <stanislaw.gruszka@linux.intel.com>
>=20
> LGTM! genetlink code is a bit hot lately, to avoid any conflicts can
> I put the first patch (or all of them) on a shared branch for both
> netdev and PM to pull in? Once the other two patches are reviewed,
> obviously.
>=20
If netlink maintainers are happy with the 1/3, you can take 1/3. Once
merged, the PM patches can go separately as they need 1/3.

Hi Daniel,
Please look at 2/3 and also 3/3 if you can.

Thanks,
Srinivas





