Return-Path: <linux-pm+bounces-35263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C934B97ED3
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 02:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869F119C0E05
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F2A1B4231;
	Wed, 24 Sep 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="hCpWrpVb"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51A1A23AF
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674643; cv=pass; b=UDwaQmqfc8YXYX28G8nDy1FHntb1fCelLOijHf239H4rYdEjUfP7oozFOSxsUupHTBTUAQH/seFtPMB2mCUlbUmXa43/v/eyr4oj/os6ftcvQN6ziamK29G3dr9k9fUvZ3Bu/Z8pJEYGSLI5ufigV1AIaszPQSRXEBg+r1E7bak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674643; c=relaxed/simple;
	bh=3n0pQtDkncQUO9sAwiVLMScqSEFrhLGxDteCAFHeKEk=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=Z1QGrjsgiRSx5ZyRRyenN0k5T9D2o1p2c88J6EYSAvUGpIOOz/146GzSJsuP+sg4G2DtzOrkzIzDe+uNASeqt2MIQ7AiyRFQnFJibyV/TjjfYKFISh05IhrZyTuBp7kxIlITbsSBjm1Xf4/YzKExhcLekhurjz7ZiUPZBX0TMKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=hCpWrpVb; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674641; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=ZRb55pShJmdsA5toiuLX1qTNs8xHqehEHH3Y24ZZpdqfU1BVXPh5LNg3NreConF4QfE9AlHPHDM4jeCqGNf4YHzCJFXKF7Zkqp72PS9GXn2ahSx/G2MY0KS9MpQByKZKwo0NsryMhA9CNUyvwLdwkmcc/h/iVzduauO2mx+yLZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674641; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=3n0pQtDkncQUO9sAwiVLMScqSEFrhLGxDteCAFHeKEk=; 
	b=aMBVjn2tdGv+EJln8U3SdMZbB6N9yb8JqRlQN1K60TNxrRoUwo3B2LL/OviKjH1CPMQRbmBTk7qRIgQLznBiKQg0S+Xp34gOFq9/M80gRVQLcYOeiKRGuqeGQbtcKoOg2IwWxn5MBBt9uhXXNew4fCwO4IOt9JyHkCm6rhmygB0=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9aa04d00-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671652884515.0509439257143;
	Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=hCpWrpVbgobUy9zHjew/FJXdJ2JnmiB9DKuEQSxTMu/2SoJB9Zj2OWkT/3Wfby0Mo4LK08uWif4xjWnakbl+RPU/kAPIPKcu34PYtX10qkEjDcHUJ+hmeBMmhVmfzHVnHrGoy0zfNogo/ksEVVKyq9dJLqsjzYyBkabpclT8Wbw=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=3n0pQtDkncQUO9sAwiVLMScqSEFrhLGxDteCAFHeKEk=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-pm@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9aa04d00-98d8-11f0-ace3-525400721611.19978ffc5d0@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9aa04d00-98d8-11f0-ace3-525400721611.19978ffc5d0
X-JID: 2d6f.1aedd99b146bc1ac.s1.9aa04d00-98d8-11f0-ace3-525400721611.19978ffc5d0
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9aa04d00-98d8-11f0-ace3-525400721611.19978ffc5d0
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9aa04d00-98d8-11f0-ace3-525400721611.19978ffc5d0
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9aa04d00-98d8-11f0-ace3-525400721611.19978ffc5d0@zeptomail.com>
X-ZohoMailClient: External

To: linux-pm@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

