Return-Path: <linux-pm+bounces-36353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FABE8BE2
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B2565186
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985C331A74;
	Fri, 17 Oct 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="lVC19zam"
X-Original-To: linux-pm@vger.kernel.org
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E63451C1
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706312; cv=none; b=qe6GFBH2OiwZhro+q6Er/pfY/YuSyxu7RfimL+hZmjCbzT1Iu+hTrYNHNhVerPzsmT8lBayRFZDGi8xvBwXrxokMx/tkobqPHyx1ZQo1yaCJ+UvsRD3EnEibbA51MYtrVcWZXNZoxTnr1M4StmtwILdtYJjly/1tJ7I2uCRGQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706312; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PXAtN+I9lSW3N78VHWSLGDI09cBRQVNtCBBma8WU3PooHNaEbyUsWhBvwuoBvruK7n9goTcUna/bys7QTOKGMOjt3TyJzY0fbe33ZQr1YOfqTaPikRnPS5+hJO1TjnD71FsSISZsmYk2jG2Sl9uNhUlfEg+9HnVBIZLlrBE8W8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=lVC19zam reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id DE6DC49027A9
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 07:45:35 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705136; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=lVC19zamzeE0B0k3x7FhTw9rmCmI/hjJ9C82glkDSti/bKehXKftzSiP7F9evB934at2xM
	yXLFMlBW4F6le2V/NCOagSa6h55lWA4+OS3QtPQ/A2ye6HuLawC06pMvue5tBJmeUJOFcw
	Yr9nChkBX0Yirrn7gyx1t/GNg/KvFbGOj9XW7vkwvcLxImT0usQ/XdtOWKa+zLTLjeks/T
	OEGZdgQZvWZrbrU1ev/hY/4ZdfJWzZSR5Qkk88OWG1NvWDPvvmJhbNG3KXnY2RT/Y504QC
	HwvAhV91crykgq1R1+B5r9whuQ3yJf75Xktr+IH8bVZA+5hdvdOhxoG9RwJZAA==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-pm@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:34 -0700
Message-ID: <20251017054533.3856CCA2892DF9C0@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

