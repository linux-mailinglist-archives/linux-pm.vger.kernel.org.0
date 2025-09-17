Return-Path: <linux-pm+bounces-34818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955FBB7F3BE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1F5279B1
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0662F4A0F;
	Wed, 17 Sep 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="y3rcKqy8";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="ZkWECd8F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52DA945;
	Wed, 17 Sep 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076107; cv=none; b=MZ0d1kOEQo/PwV6Jg0tpjisD7TDQk+LyL4ElFKrVRGaPMaq93m/xGj/HSXKz/FOZFs0jfuqVvVFJ27wEAlmoSusg170OznY8NA2Y33uMpOLtdOtEmnF/D5G/95OpRPDRTKWu0V4XM2YsWwAIg9SSj52VuI90EPz01wDP35mN0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076107; c=relaxed/simple;
	bh=OnpiZSO0b+Sxjgg34yMJ7AAqILDqY4/TGFhPauWwkdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/uzYNlqZ7YDFWJgPRjcUJ+XTrBfB3bktYn9zRsX250gs2r2/u7d/D8RJ+5GnkUggt+ykBcf2M7RrQz+kiy2EZyWoDorx0ZjFP4oOfWWvgX+qbPj91mB0uxmf1eW55JoMpzxWwAsmdk2B3KiVE2n2yJK82yoIGCT6FUmnNj0R5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=y3rcKqy8; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=ZkWECd8F; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1758076102;
	bh=+TW4aUZsbAAxJpYRNd4uBBxUv/b/AscrjcBfhNX6yts=; l=617;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=y3rcKqy8LsZm7aH00g8hocbILVzuKiweCuNIN4YCVk2W1EYBm21HE4VzPZ8Qto2B8
	 2q8Umj35U72y8xsMpykTU8wF8XXUfKl7M27+ygFucAHrDIDT55yHhUAWI7o34N6wGA
	 pIsO0Ch57cTos+qFhjgTTNQAWZjBu9fs1We+xqz48YsJgqxxMJ7Rwm0EPUqV5bKXzV
	 NPIukXJHES2grvesbIRd+XEYjg6Pl/XVmoykd1ICFctEnhzL0eXfinKiDI9dsRpkTf
	 nl5Mq4hZQGeiYH8H11Ilc4kuX7Grox8gYMXUuMCqcnLeuKgiMmBouOQ9qTdvsfPiqn
	 B15qlGpFWKEzw==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128080:0:AUTH_RELAY)
	(envelope-from <prvs=13528E3224=cy_huang@richtek.com>); Wed, 17 Sep 2025 10:28:19 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1758076099;
	bh=+TW4aUZsbAAxJpYRNd4uBBxUv/b/AscrjcBfhNX6yts=; l=617;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ZkWECd8FZM49zNKNCqNfRYfZGFICPA+ZCrWiuQG1eY9qPSf6EVO7pAA5NIdiinBI8
	 Ab05PX5JnykuFqeJkOm+mT3gSDB/ATAvn9ZAf+8mw9i0SVVbONH5jJkfW0gyJDivOu
	 x8HSy08jfNZUbA5AKMSWCNkhgK9Ul2uynoI4bHWVnN68UKyfo/uaHi9A0ZCbLI6IRu
	 6yx8kGCOkJxGuhOzPmwUR1aiEYXefdGeGKvJtP+Eb2ejqkLQ4w/m8ErS9Plyw/P9ub
	 c/UAfvy9u3WaDSRjUgnriuxX0asNLJGk2SVZrCN+ckpYLGue3AVGPLEoleQG/WISxi
	 h2lpNVM5MKmKQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2461095:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 17 Sep 2025 10:18:33 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 17 Sep
 2025 10:18:33 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Wed, 17 Sep 2025 10:18:33 +0800
Date: Wed, 17 Sep 2025 10:19:44 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 0/3] Add Richtek RT9756 Smart-Cap divider
 charger
Message-ID: <aMoawDH7V/ea4i62@git-send.richtek.com>
References: <cover.1755154950.git.cy_huang@richtek.com>
 <aLY3/dNLdF/Iiwq6@git-send.richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aLY3/dNLdF/Iiwq6@git-send.richtek.com>

On Tue, Sep 02, 2025 at 08:19:09AM +0800, ChiYuan Huang wrote:
> On Thu, Aug 14, 2025 at 03:31:05PM +0800, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > This patch series adds support for RT9756 charger.
> > 
> > RESEND V2
> > - Add 'Reviewed-by' tag in dt-binding patch
> > 
> > V2
> > - Add reference to 'power-supply.yaml'
> > - Remove 'wakeup-source' from required property list
> > - Use 'unevaluatedProperties' to replace 'additionalProperties'
> 
> Ping......
> It's been one month not receive any patch review comment.
> 
Ping again.
> Regards,
> ChiYuan.

