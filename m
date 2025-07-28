Return-Path: <linux-pm+bounces-31445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D19B13333
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 04:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026303B71EA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30C202997;
	Mon, 28 Jul 2025 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="P2pdD3lI";
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="HBzph/Wu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74C1FBE80;
	Mon, 28 Jul 2025 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671331; cv=none; b=cHPsmbtkNd0Tz7qfGG8kjgc1lBf8QL1xCA23Ox1l/R+xOCp5GWMAGn52/5hmPUt8lDPKHxXw9EcHITQf8+inLXs0PDN9YPxhh9a8BmJiobFohUuFcY4EDr6ZMBhdGgXbqED0RkKfsmGbwXpradedSc9ZnW0jDCBjgxyZxQo+Qwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671331; c=relaxed/simple;
	bh=53mj4tIwur33Mk75aJKG2K9HfhifJ92nV/eqHlmhM/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6ec+sHP1gtMty73nGwvjRJ2UBi1lRcQlC2SjnRH8gZhqcKJBDXIOWUN5nhheGirQ1n9U+BmSTZV87mV5ObGVr+FXBvOzpaHUFWoeBzMltVzCWz5oZr7vFLplJoh1ZXRY1pmSxwbhkK0o6ceeDOhLs9IKw8C2i+SQkr3JLVP4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=P2pdD3lI; dkim=fail (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=HBzph/Wu reason="length tag value exceeds body size"; arc=none smtp.client-ip=220.130.44.152; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753671325;
	bh=rH5H2qzUPBwA91EKNrnav/O5zSrCiN45VYvC6I+auwQ=; l=322;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=P2pdD3lI/xSz8Av6a1Me2f3b0dYWb8WDV3ssM3sMug0amjmG0kx7NL5eQrd55kbLT
	 Hv08tSAov3DSoSNfDareNmlq558MHn965h0GY2NCisnYj9RMXBBiieo8ixjxxQzA7D
	 1jeovl6rUgRrniK4BECCYqAGLNb2WMffAkZuWf454mLOVpzFXfH6Lg8gohcFAuuFQh
	 RP8m8z5RoranPJuiaoTyHZ2LjX0/IISw39vQ6rrag8e1TrIt7F68c6Y3IduopROGEk
	 qBWC+/avPFVoC9hZq0aaZUn989OVNa6p9IfbII2omLyJh/fB+EDRqgKXtsdBqL6GEQ
	 RWJDxXOPKyURw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244573:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 28 Jul 2025 10:55:19 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Jul
 2025 10:55:18 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Mon, 28 Jul 2025 10:55:18 +0800
From: cy_huang@richtek.com
To: cy_huang@richtek.com,
	Sebastian Reichel <sre@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: supply: rt9467: Add properties for VBUS and IBUS reading
Date: Mon, 28 Jul 2025 10:54:37 +0800
Message-ID: <20250728025558.2796502-1-cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1752542001.git.cy_huang@richtek.com>
References: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1752542001.git.cy_huang@richtek.com>
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E717C21B; Tue, 15 Jul 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com; s=richtek; t=1752542356; bh=nFc7sXSxrxXrn9CbhO94nNCIuL9JOjq3fHd1XbxNFLE=; l=1888; h=From:To:Subject:Date:Message-ID:MIME-Version; b=HBzph/WuA8cLgQDpZoE2w4LfTP2epfCOlVcGC94BMYegXUmrYEXYMZgWnrLSduaSL Rvn5Gh189VNU078dOpXd1rfMqS+zfzE1pnhtX+u7r5WIPchzGgNQJZkx3qDOHIaxhi U4nPegYOcDtJbF4WUrlHHJ/YRB0YYVtDt36sMZ5TDyE5V4s5SBwNPHsvINhMAhpCym fzp94lWsWdJvgIr5D8od4dURjjxbOrV3s5bjffEds4fri0OgoLHMe9lxMgyi7wiljK LkAzTCHEMQdsTwy6SXQc+s5EUU93dVK3JPKeNLnsgRSFGgPFxS4sOTIIW1eakfwz8m 1MjtFGU2LqjfA==
Received: from 192.168.10.47 by mg.richtek.com with MailGates ESMTPS Server V6.0(244604:0:AUTH_RELAY) (envelope-from <cy_huang@richtek.com>) (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 15 Jul 2025 09:19:05 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Jul 2025 09:19:05 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend Transport; Tue, 15 Jul 2025 09:19:05 +0800
X-Mailer: git-send-email 2.43.5
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

From: <cy_huang@richtek.com>

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Since there's the existing ADC function, add properties 'VOLTAGE_NOW'
> and 'CURRENT_NOW' to report the current VBUS and IBUS value, respectively.
Sorry, seems message-id conflict. Re-send it again.

Hi, any comment about this patch?


