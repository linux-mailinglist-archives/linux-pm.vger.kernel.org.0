Return-Path: <linux-pm+bounces-16376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9A9AE467
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337C12847F5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376E1CFEB5;
	Thu, 24 Oct 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kkevNCjO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DA1C9B87;
	Thu, 24 Oct 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771720; cv=none; b=eb8mIrans2ckiZKMxZ8qC8y4cXJF4ZKaizZfeKooctPuHbjSiALe9xlbBu5Ds6MbB9N33tsAn30LdqqAwbaCZ00ghhmB4LGMSL8+JeHgCE72/JZ76IuApR9TeyH89vBiw1jza6rj4mokgQoS1t/3BUJD4Azgx5XpiccuYBAVSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771720; c=relaxed/simple;
	bh=x1NkWx3tF5LPDqz35K6XEFFHP02DOtJjEdaY2fElJKc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SlRJdjNtdNjkntB1/Dp+w6PllBDn1sn+LD337E+uKkrTKeMuSqY/OSeYjH6nFlI7JYPg5qeqBqQhTwHZegOcT0ogsDKGWJBUa05utiKOJp6dxu1+qM8YuVWAQgOFqGNyWU475LLOfCdo75KmI549cnuHQ57vXT/ECrVuE1CTBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kkevNCjO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729771703; x=1730376503; i=markus.elfring@web.de;
	bh=KxHQObAgoRGgCjZbLssB8OzTykXM+qnlmZAP2u87rwA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kkevNCjOWNFT5rCe5ZkJZONMow8J8xV4z70IGzd4MPH7J0C/w90kWdUgaNi7mqOO
	 gzoB/I7e8lCYtqcdgUpopTc2Co5PN6bXR8ByGlqXSWpivZeiYkhMZeBe6Pv9kNGMq
	 Zmd4kcib73eKNEOD5agcye8MxDCheX67tZodAwS8p1e9++muMnsNfEpVtoWq77LAP
	 RcKLxDo48gZIXYFtF9GYOh1px9g/Nm4UG8RwroTfv74LrUDjhZZN/a0Z5E5+qY6I+
	 4VHEyteQf/g6aUDWb50OktRUIMsk6WtFoDKpT9TtNaNjdGf2sP+dflwk05w3ItUUf
	 pnbWVUdCheQRKNcvPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melf5-1teeHQ31dd-00meYd; Thu, 24
 Oct 2024 14:02:53 +0200
Message-ID: <45265aca-7371-455f-819f-c4d68cbb089b@web.de>
Date: Thu, 24 Oct 2024 14:02:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2bME+PCDsScDnQs42kYKZH18Egd3SQKTjQ7WUY8unvoRuc7OLKF
 X82NXt4uZklSReE8A0/EGpQqQibhH4JcN0hOYYSnVXlWNZgdxEzqjvFRg5T9VXFyfCBO1wg
 NSEtaLYqG8eO0dzFkH+4gvK1kqcFAASCnj1IWbPsme2Wb5pcjB3qSuZqYBmUBIGrG1cMk0X
 3CfPc4tKMMP7fHxIzcT0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k3SblLoJH9s=;pnmxE5HTvH0yst0qau6nQxGkI4/
 Oq31t9oj3dQ67xTMxuA6pfiQtbmKAvp+D9uvku1PRDWFQSYNs7Cf1CrFtM2irn6pUdCtIIuxj
 GhR3Fkz6y7I1Mv7bSZO9d/GHOgnvKl38J1BasH9N7exr+/h4RiED9KRmlbClSTHSL2Ayn5YzH
 VdiEuI0zUcpPqUOoDgtt7ahK7LPXogwdToPSTcM/PCD2Tb5kEnhISdM5s5pojBFDCMsrGN5Y4
 JNZufTuwfSJY0CnVkdFaLCNS4LuZCnmVG++dT6+oJLpCR6v7x2ZMYwx4t+cbkxfEXhYFJdm4Y
 17F1HwXcMNh3D9VlJUH/j67ifW1qP7lh4oR080XrCfD+B4ZVGWiVo7KrIrBk08mEO6c7nmN3Z
 jZn9mdjV5QoAR0B/khWgetR2PGchTPo0hiXp2PsxX3yLYwzrDuR9HeZizQ2MR6tOmB69PvnI2
 tWOexBrrQCipiBX4oGt5YF9RLEd8pTpOwcgzL+rz9yjpo5uTE0GutxprG8ucscL8CV3codP8G
 K24NAMjjB19zReNdSSWJObidnxU/EfUBdozQMy/3U2axk+uj51hbyDfROC5BjGLwA/bfBfvpb
 bR2aC+Cohv4TZuxFqt3qdblKqhacIT1akPIbbNWH0tRpjB5IsKhg89mlsyufdHWjp3L9xNLvM
 IxqHfn92DylzoMgS8cMo0ak0nhb9wG3b7wzzeSp0ZiNTcCH5BhNlGeHxMzKaYjhe7xonb2Sup
 p3mkBtRyTS70PRkg5YZmKP2KjlA3lJsQjxIMrj6Rh7v7iqdg95axiIvYDjzlZ9ikr/tYjvm3+
 CxQ/swqfPTgGiWag+Z2hHbSA==

> The function thermal_genl_auto() does not free the allocated message
> in the error path. Fix that by putting a out label and jump to it
> which will free the message instead of directly returning an error.

Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=9C=
Cc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc4#n145


=E2=80=A6
> +++ b/tools/lib/thermal/commands.c
> @@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct th=
ermal_handler *th, cmd_cb_t cm
>  					 struct cmd_param *param,
>  					 int cmd, int flags, void *arg)
>  {
> +	thermal_error_t ret =3D THERMAL_ERROR;
>  	struct nl_msg *msg;
>  	void *hdr;
>
>  	msg =3D nlmsg_alloc();
>  	if (!msg)
> -		return THERMAL_ERROR;
> +		goto out;
=E2=80=A6

Is it really reasonable to pass a null pointer (from a failed function cal=
l)
to a subsequent nlmsg_free() call?

Can it be more appropriate to return directly in such an error case?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.12-rc4#n532

Regards,
Markus

