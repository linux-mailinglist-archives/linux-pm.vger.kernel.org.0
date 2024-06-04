Return-Path: <linux-pm+bounces-8566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30B8FAEC9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A8A28204B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5B13B29F;
	Tue,  4 Jun 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="YVlCYroB"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496A39FCE;
	Tue,  4 Jun 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493425; cv=none; b=NFfZsWwyv/JULfEBNZzMRqNS8CTDjvlOhAhUkIoHOh78KLjGiuZCew19ydf+AGlgPb9nkDrlt4iFsOTv50nJTMo9PG1uPKRhgTRMLsotgvuVe3v4K4ZVqgZp7f0aOJwQb37+BfmiRZtvFeylrnBExGqiF8anWhQGuLQjy0Y9x9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493425; c=relaxed/simple;
	bh=Qx8MxPQX33Ba6WlaPwwBuVOgH9iS8300glRn1WMltPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvRiKYd2uESeqLQQJC24t5B4i5OfKpIMqd6XffiLDqR0QLegcJGpU5cwANqgwEy3Hm8WiJkS71fwuo/k78Fy3yesuLuL3Dce4JnIwQtGG2s9MC53PdcFg8Rl/ZY/qs9aJ/NXJjTTNFIv+mv4UBKg0DbBOhM5tl1xXk+/OwOfqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=YVlCYroB; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717493422;
	bh=Qx8MxPQX33Ba6WlaPwwBuVOgH9iS8300glRn1WMltPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YVlCYroBwZuRnfatZYJS6r/4aJV7BS8s5+fSUxuM1BqvZLCOS7TDPC6nIodJ98+s2
	 8WhJNTVJ+ZjkLdgIS/96fX15yoVfiZgiGrPl65fqro2bdcAmcVNO2eXTmzG8uCpdL3
	 Zz1kL1bMMOl5b2ZbmyUyjwaE6rWNF6JPI7V8NIfc=
Received: from [192.168.124.13] (unknown [113.200.174.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7684E67200;
	Tue,  4 Jun 2024 05:30:20 -0400 (EDT)
Message-ID: <aa643910265b9d92a397d5148b31d37b2c421b8b.camel@xry111.site>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: Xi Ruoyao <xry111@xry111.site>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jun 2024 17:30:16 +0800
In-Reply-To: <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
	 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
	 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
	 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
	 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
	 <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
	 <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
	 <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
	 <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 21:31 -0700, srinivas pandruvada wrote:

> > > Second, a delayed work can be added to check the MSR long enough
> > > after
> > > initialization and update global.turbo_disabled if it is 1.=20
> > > However,
> > > that would require some code surgery.
> >
> Something like the attached which does same way as user space no_turbo
> update.

> =C2=A0static int intel_pstate_register_driver(struct cpufreq_driver *driv=
er)
> =C2=A0{
> =C2=A0	int ret;
> @@ -3114,6 +3137,9 @@ static int intel_pstate_register_driver(struct cpuf=
req_driver *driver)
> =C2=A0	global.turbo_disabled =3D turbo_is_disabled();
> =C2=A0	global.no_turbo =3D global.turbo_disabled;
> =C2=A0
> +	if (global.turbo_disabled)
> +		schedule_delayed_work(&turbo_work, HZ);
> +

I have to change it to 20 * HZ to make it work for me.  15 * HZ does not
work.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

