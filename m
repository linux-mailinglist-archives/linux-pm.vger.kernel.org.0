Return-Path: <linux-pm+bounces-22120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C34CCA368E8
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1D318933AD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 23:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5AF1DE2B4;
	Fri, 14 Feb 2025 23:09:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from rdmp.org (unknown [195.15.247.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD51A83F2
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.15.247.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574583; cv=none; b=cLeQR+ct6j5aEV+z13qBKKlVb+QvBGzLsPpGX5PcXGWXMDp/uiZNFlr/6LgyXzHPiIgxSDiVQSVMyvNntqzFv75NlHcAIfLPjLQA7G/t9tKodWImZvwCp/TOg13WSL7wbo4IbS3rcptnNns4VY3NrJBEe+FD9eTPOuYbi6wawgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574583; c=relaxed/simple;
	bh=V8syrvc4bH7J19xYbg1nabs9yF1pXhHBhsaYi5FBntU=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Csm90KFn7UeWa3kGmVsVvvQGWo7ldaYOQJtpP6ZwwxYhcR5S44MR4uWAFlXHKx10Ur4uFJ53uq6PNtW3aPU1792RNvP61gr3c5jhGU4DvLHL+x3JtqW1P7nv7uLhurvuYFojLA7kdA2Lo/Xp7gA/rtySBXX5AMY3oPTtNxngpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org; spf=pass smtp.mailfrom=rdmp.org; arc=none smtp.client-ip=195.15.247.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rdmp.org
Received: from [127.0.0.1] (helo=[IPv6:::1])
	by rdmp.org with esmtp (Exim 4.96.1)
	(envelope-from <no-reply@rdmp.org>)
	id 1tj4oW-0000NY-0A
	for linux-pm@vger.kernel.org;
	Fri, 14 Feb 2025 23:09:40 +0000
Message-ID: <1e2af6bddb8cd51e5076285659a6f5bc92b026f9.camel@rdmp.org>
Subject: How should userland app be notified when kernel comes out of
 suspend or hibernation?
From: Dale Mellor <no-reply@rdmp.org>
Reply-To: mcron-lsfnyl@rdmp.org
To: linux-pm@vger.kernel.org
Date: Fri, 14 Feb 2025 23:09:34 +0000
Organization: DM Bespoke Computer Solutions Ltd
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-LbBRMvfSx6CwLGdP2rb7"
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-LbBRMvfSx6CwLGdP2rb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am the originator of the GNU mcron app, which waits (using select)
for set amounts of time before executing some function on behalf of the
user.  But when the system comes out of sleep the timings are all wrong
and need to be re-evaluated.  But how does my application know when
this needs to happen?

I'm currently trying to use the ACPI netlink interface, which
conveniently gives me a socket I can add to the select call and wakes
me up when some power-changing event occurs.  However, there is not an
event specifically for notifying the coming out of sleep, and different
systems will have different hardware which reacts in this situation
(the netlink interface has a soft specification and requires
introspection to understand the data it delivers).

What is the 'official' way to do this?


--=-LbBRMvfSx6CwLGdP2rb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iF0EABEKAB0WIQTiPCHthk/086cRTN/KRx/VAWGKSQUCZ6/NLgAKCRDKRx/VAWGK
SScMAJ9ownEcXzpqVQ+DoB5Qi6bN6VLeOwCcDzePFw8kh2vUpib7WiOYO3wkvJA=
=KAeF
-----END PGP SIGNATURE-----

--=-LbBRMvfSx6CwLGdP2rb7--

