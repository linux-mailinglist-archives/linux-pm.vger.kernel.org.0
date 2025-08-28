Return-Path: <linux-pm+bounces-33331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C209B3AB4E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92C37C29F9
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F527CCE2;
	Thu, 28 Aug 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="mm+O8DMb";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="41ahrUPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C72571DD;
	Thu, 28 Aug 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411967; cv=pass; b=PHyolhIHRtsDxTSHIGd3DJyn6PW1nTTRFmOZcPbDuBinDtqlaC0yLYqYZARsUsawYXm+eIH5ogQj1N6cVjpDe4PaAPSjhMevmdkNA74By4rktW9rs+svX+l3qzOfJiEwH9VFGSeTBbUNxpqr+I6ARh4I1z4JH8a0CZhUpErO0nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411967; c=relaxed/simple;
	bh=sujAEBpJxPjxhtjKUx+ja1aGWF8z5yDtaVg78NxOtbg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IT16r8SwfTUvzLhOsQxY+RyjnRyE5iif2W8Ve4XaQ+FZsdrg3tGqWufGeyhK62l0TmPPz9fovNSAVa4JTtbaXt+Ta9f6C8t9KTcY06p1APwA4gcmFfFc5jE46MtqnS4lAl6fvgzHBADxMaKpG4fZhdR/vZY/3C8AO2PK3jRMI/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=mm+O8DMb; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=41ahrUPU; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1756411931; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qHyCgw0HXKSqYCYTFeL8rHR84yNnKYbRLS9fwuvkC+FzvJtqZVQd09P7rXmr0ykFkK
    Jzmny8lYjDDx/yglt27k1jQLG0jxy7DFDTlrnSeOvV6h1C5mLnIZterjMQayzIUOL0uQ
    jSo59a/qG8XmhdU+6IP6UXbuB2S3d6Dn1ip2WGdNRpDEfAP/jo9/kciCABwQG7pPj9f8
    55z/Wwk/+X8Zj6Fcuz2l5OGy6EpZPKpmDJv3AlTix+hihpGbQQj8EQNYGyLBkfyvglwJ
    vs5KvAKhtAKyKnOEz9oc3wZi+cik9U4N69+o2uO1gwA1Ts8WYsbgybP1vt/B/rXYiwgf
    3n6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756411931;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KbRCLVSjf9/WslBZgDdGCzMFH5RfGIaJX1KwUJL3xeQ=;
    b=JcnT7hH+dQ3VgIbrwgC9230CjQOXJhfXgze4uJhtGS7uVOgWqh9pAGfM7Yumi3IVCK
    AwDgceZfw17zTrkgeJwmUcjJmCkNNY0qgvf/YJwNlvljvGotc+UE9ByEBUmRSrV85lac
    7ifeyQJgxghd1TxpyAzr0n1OioMZhexJusuQMhdAFqXVTWoY+mPsu+cyVytlnU0/JjLW
    hXEVIGbOTpy2ywNYtqoLmIVPWXUhdHhHMY2B9gS7L2gIKdyjvMcGrd+ZqsHVX/rSBUYA
    RRfasSjWBpNzZSp2a/o5Un9p41k4lFn1XCpfKpYGn3g1DNRdQM+Nibg25AYPcifPY4GS
    MzDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756411931;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KbRCLVSjf9/WslBZgDdGCzMFH5RfGIaJX1KwUJL3xeQ=;
    b=mm+O8DMbblNBUSngETBftyXk2v//FwjHtXBVDbLcWvAxV9npWbE1RovaKT9K7WpgOb
    O0iu4KAxTWD25ftEQMVHBRY2FHlshi8+HReDITsTa7/f9dXxf4Q0YK6Imzq0gbOK2AnD
    u4I/yR8bNwPfhFQ1NkW8UAbLtQ91JS40+Z8sbwIz2De5JakGL4gm2dCtbs9OAuRmagj3
    sf9EXN+gH3xUFyuC4WUkzU6LbjYw7d44dwmliC/q7Kq5GYf4ExUCkoTO6XiKBxdX4nQo
    iwY3V8UT7Dy/NTRee95Ubm6+kGzoTppgZQBSvfQrqxegjPOmKNYQ0/v5yXPXzRPq/dJy
    jElg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756411931;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KbRCLVSjf9/WslBZgDdGCzMFH5RfGIaJX1KwUJL3xeQ=;
    b=41ahrUPUv5+PK0PR7qc/azE41VvqlABzxNZW63qkXILU+mi2fYmQL3dmwYdTXYuML+
    YPTtbKfN2yUt67VydXBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT3poOmsiN2w31h2+GBVG4/sHBcUyJsCRpvmGv"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id Q307a417SKCApus
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 28 Aug 2025 22:12:10 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 0/2] power: supply: bq27xxx: bug fixes
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20250828202421.57bbbd2c@akair>
Date: Thu, 28 Aug 2025 22:11:59 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
 Jerry Lv <Jerry.Lv@axis.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org,
 kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <34413DBE-C225-4335-A0C8-B7E0DE53BF32@goldelico.com>
References: <cover.1755945297.git.hns@goldelico.com>
 <20250828202421.57bbbd2c@akair>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.700.81)



> Am 28.08.2025 um 20:24 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Am Sat, 23 Aug 2025 12:34:55 +0200
> schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:
>=20
>> PATCH V2 2025-08-23 12:33:18:
>> Changes:
>> * improved commit description of main fix
>> * new patch: adds a restriction of historical no-battery-detection =
logic to the bq27000 chip
>>=20
>> PATCH V1 2025-07-21 14:46:09:
>>=20
>>=20
>> H. Nikolaus Schaller (2):
>>  power: supply: bq27xxx: fix error return in case of no bq27000 hdq
>>    battery
>>  power: supply: bq27xxx: restrict no-battery detection to bq27000
>>=20
> hmm, is the order correct? To me to be bisectable, should it be turned
> around? Maybe Sebastian just can do that while picking it.

Well, it is to decide which of the two fuel gauges fix first...

The bq27000 is working again after the first one and the bq27z561 is no =
longer influenced after the second.

BR,
Nikolaus


