Return-Path: <linux-pm+bounces-23827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21BAA5BB30
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12493A90E2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382021E8325;
	Tue, 11 Mar 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hibnavf.top header.i=@hibnavf.top header.b="pI5dpcuW"
X-Original-To: linux-pm@vger.kernel.org
Received: from hibnavf.top (v160-251-183-180.rka7.static.cnode.jp [160.251.183.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8822576E
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.251.183.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683170; cv=none; b=eoO1lXt91ruNKW6D2aDmwvakaIpeGxrQG989hCVx9xU0Il2vrl6Ik/Ez3UGYvwweUNASS45+Yky1RPEb61wyr03LWDWtw8vo4CM9YjMFWGIk3g/GxPZ9C1DtYOamQNFYC4HJdPothJu1ljH/WTgJ3vEYgQ4WdxsGUvv7XGklWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683170; c=relaxed/simple;
	bh=j/r+ZU8ocng2qBgyRdeMZwQ3hdTKS3WqQbWXN6Z8cp8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MUax8FYC0omUX0ii44vyGthz6Pk+x2SMPywwaFKYe4tuC6Dbi4JMNg1M0+kpydd4WPXZFWztgGNoP+HeDfcKoT+vgklMMxaIOy3RW+WErRm6o+1qwdfbiD/EAM0NqGmw3RsOa7s2dsH2JJz0zAjnRAb7n7epDvhVBs3FxVnT2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hibnavf.top; spf=pass smtp.mailfrom=hibnavf.top; dkim=pass (2048-bit key) header.d=hibnavf.top header.i=@hibnavf.top header.b=pI5dpcuW; arc=none smtp.client-ip=160.251.183.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hibnavf.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hibnavf.top
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hibnavf.top; s=mail;
	t=1741681832; bh=j/r+ZU8ocng2qBgyRdeMZwQ3hdTKS3WqQbWXN6Z8cp8=;
	h=From:To:Subject:Date:From;
	b=pI5dpcuWaJFlHQZyBK5gtoYvTgACF+VnqhDCUlptEIHcb9rztgJOI1WMU5NiatR6w
	 9u55oXPdS4GrNQeC1By12Jm8vGV3WoTmHXINozyN6BfjXjAY8HcLJ4Jhi4VhkIY8xn
	 yY7m0oyKCGgrfE50b6LsYicDaROFz/a+LCfO3TTEIeCKDN+ohFrj1mmeNEGUpAfcbh
	 G7cuVukBC+/QlCwfO9AZJoQlNZgpJRUcBAM5FjVfW3f/kt/51PVvEoA/tttUtyAKBc
	 6PGfkvNHJOEgzT3JlIGQSvJn4MlN8ZTCv877lYslzo7DsM0ML+EfMrTIjOqab90SL1
	 lpaJXPrUkTPOg==
Received: from budgetownse.cyou (x162-43-58-98.static.xvps.ne.jp [162.43.58.98])
	by hibnavf.top (Postfix) with ESMTPSA id C975D103E53
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:30:32 +0900 (JST)
From: =?iso-2022-jp?B?GyRCJEklYiUtJU0ldiRmJEEbKEI=?= <service_1@hibnavf.top>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Ailyn hello
Date: Tue, 11 Mar 2025 17:30:31 +0900
Message-ID: <FHPNIPHNGDGDABONLDONJDADGIBE.service_1@hibnavf.top>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: base64
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180

bGludXgtcG0sPxskQjklGyhCDQoNCg0KDQoNCg0KMjAyNS0wMy0xMSAxNzozMDozMQ0KDQo=


