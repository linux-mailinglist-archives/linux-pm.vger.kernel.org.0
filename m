Return-Path: <linux-pm+bounces-33593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96142B3F195
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 02:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A36C202E13
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11422DE71A;
	Tue,  2 Sep 2025 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="PMjZcnE9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1F32F747;
	Tue,  2 Sep 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756772949; cv=none; b=IQUcQ44Fh7htzhAH/8wtYAd+Cq5jfdJGuRy2tzNHz75ph1Ua9jKAyE3ynYFNIum0KvePP6cF6ZxJHoa8A/4dfYIFIxzMm6qg83WJFPzlSsZBpYwLGYtaaxzj6k1OJaZ0QPLVsaUNgDYCgI0M6KmA1Ntct+KtxaUWkMNegIz8UbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756772949; c=relaxed/simple;
	bh=GrfxPhJo8/AyqVq9Qy5CG2i9z5qbo/JfGKaI5+ITllA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF6deQnQKk1DqcfChc5OYUY4Q+sDQVUDU+onlSjRNKDKIeUn6MSMNtjIZ1H1r/dJHGVBq44lK1AML9S10hKOomTYl/NjxxAPx7K6gQc8cnutUqfj7UOByVJ+8PV/h7Wi0YfJn08aI+HZMSFi7BuQhGs+K4FvN1Bo61NBAaEea/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=PMjZcnE9; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1756772944;
	bh=UOrIgomgcc83X3uXVqb+ClQl4pdlIBKfzmTpZ6GlDPg=; l=305;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=PMjZcnE91n8vE1Zbl0zPxjO+gf1SdVHtndQzMI6b/aNa8DC8oDA4jG+pclF5oLve2
	 JoaF9V5MD2ktUizJYgXZ1SchgN0DPjj3KH2FY2H+GDXLJ23MhzU1JPs1AEcyYPDEpQ
	 5qlZ1NfuIe7TbBUH1SjsN31Me3s7QbWf8Uexnap6zXDRT+z8UhPoX9r1Pp838HS5Mm
	 Z0x/GnAQX+++8vWmS0z3f/W4w5eWC0ZIs0RLJAwXzEYclZHqi7QNZXuszfswiKZWtg
	 hXtc2KZgI4HBR7Sb3K96/0Xy1Q1li7aSb3/hT5dy6i4qdhiRiS/btKNzrBLD0yE47+
	 2ht+X+7eMgDKQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2461124:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 02 Sep 2025 08:28:58 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 2 Sep
 2025 08:28:58 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 2 Sep 2025 08:28:58 +0800
Date: Tue, 2 Sep 2025 08:30:01 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND^2] power: supply: rt9467: Add properties for VBUS
 and IBUS reading
Message-ID: <aLY6ie3NHtjL0Z0i@git-send.richtek.com>
References: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1755156213.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1755156213.git.cy_huang@richtek.com>

On Thu, Aug 14, 2025 at 03:27:41PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Since there's the existing ADC function, add properties 'VOLTAGE_NOW'
> and 'CURRENT_NOW' to report the current VBUS and IBUS value, respectively.

Ping.....

Regards
ChiYuan.

