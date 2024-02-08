Return-Path: <linux-pm+bounces-3631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E285784E140
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 13:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9470F28BD32
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30105762E9;
	Thu,  8 Feb 2024 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dgn0TGWQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C42AD04
	for <linux-pm@vger.kernel.org>; Thu,  8 Feb 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396971; cv=none; b=gK77cbTPFK2kSuAKIP31YS4IFoYazQ5E+rcIpTSq++jrolrf7jV1aW0eYgP4UkXMaQCLbTNj0zCB1hVuoGqet76ZEU7+XeMMxIWrYaF6qxFvmvGZrtWOyz/V9GzAdkVS+sLo7qt4PvfyqiE2ulEGfX1VFpNA6vw7yww4cEJAf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396971; c=relaxed/simple;
	bh=/4+SPsu1GhsTI+zhWJHSvHvLOW70I52bGRFsCb2LqwE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=SbussfacxO2YTBW3k0MnUvEdPhWIALBReXB3dvBUi8OWOwppFIcG2po4102tJu0Gjci+YPftN9ZVtGvagSLe85ELMKXw3EywnTiogxBLqB2vHGZEp8hLNYEuakW4ZLd/CDB1kxkvzjZ+VNdpgZh36NuVZU3fYuXjDW5w0BqfkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dgn0TGWQ; arc=none smtp.client-ip=185.70.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1707396961; x=1707656161;
	bh=/4+SPsu1GhsTI+zhWJHSvHvLOW70I52bGRFsCb2LqwE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dgn0TGWQHqceMZ9U91Gb4X0CxBU+nF5QRSHVp/WtvFnKy3Qb1NoNnyUCd3rokB56i
	 MN1ga8mhsDG2ivWnKthfiIc9Ki8sIL/LUHGphItZBCiOD8WUi6PV7h/jXn0OQvGJ8f
	 1/mJJLqHORXwFcd7yfjD6Q85/2Wa/Qkoc/HikW5hUt0xyhBLF67CInMYMPcR5jdXsO
	 saJrddsPhS38EpEd0n7bWKoxf/PIDKTs8Eb9lTNFidXcaaKFsnoySQAV79Tsa3elcV
	 sKjb6mcpFPL+Q4mr3QgO47FOhR5YKrlEx1qYCbmLRiXHAvzRIc2/i+tQLZ5ysBDNiY
	 tc1Ebfm+dO14Q==
Date: Thu, 08 Feb 2024 12:55:52 +0000
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From: gigastarcraft2 <gigastarcraft2@proton.me>
Subject: Cpupower breaks KDE.
Message-ID: <hbQH_jcRM3cDhW8e5eGLx9IcIqdCmQD9Hs3Q0Vovhu2ooN8Iw7552AkwoL11Vk2HGNrk7wOL-vnFit5OLCjyge5HBpVDDkyhhBcQ5grQczg=@proton.me>
Feedback-ID: 63763610:user:proton
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, when I set a performance governor either through an OpenRC service or a=
 GUI it breaks my plasmashell on a startup. I have to manually start a plas=
mashell. I use Artix Linux OpenRC KDE Plasma 5.27.1
Regards,

Robert

