Return-Path: <linux-pm+bounces-43546-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MPfIvPzp2mtmwAAu9opvQ
	(envelope-from <linux-pm+bounces-43546-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:57:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE91FD046
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3349D309BBBD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9B390214;
	Wed,  4 Mar 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="KffHlzLf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3338239E
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614434; cv=pass; b=XPsuw8xPvToy4+igzPGnCOtv1mu/VkIidKXvCqNCXu/LOtxgAudR6oVEZzvrHz7aRmMhm/1EB0OgqeAXIs7dEWMO8hbJVh3+tiUCvDbXEdnWWpJAxEVALoP5bO2ikYhV2lt1wnEDeoWhkCN2GURPuuKD3eJK1nX7ep9/kp1S//4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614434; c=relaxed/simple;
	bh=yT7NefqTAGrFVHIy1qkdkhat9hiWg28r0H1XF+xbQgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/FPyOEBgl5AaU8GKprJy56gbjdjNiePC5tDUduxo7GQ60IpnofMqrBg0L7HjTMfsIUviQ9JE4kLfQj4iKpA6XoR8RGOjiJ56QYlS4CcZhMunaF7fJww3/LXopcu4AWRRIU8YXoRantq6ky5ZAOASKlFvYlkioWWhNdz72NpWb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=KffHlzLf; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9361c771e9so1057392166b.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 00:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772614430; cv=none;
        d=google.com; s=arc-20240605;
        b=SwbrzAjX6dNg/UY6aUiIlY+NP50wDr4mTRAOBv8AzEPi0NKqggXLF2sQiCDmU9Phe2
         JQ0cOMfO/3CnUV3OGuyN0F1tNuLOAQxotEHdFoWtBwCQz1hEXhPEX6d1uytZarXwj31S
         0Z3u8kqYO/mEaeuEgTvY+Wj4OJ318oJ1NvOfJQO/EchuBRO7MBBafKJ3HK3bR0il+QiH
         txOlESIPEcIPCuwLLrN6oozXUX/AAfeR0IjAHVrBJs4axA9Tms/wnFVxYpzW6R8qwmcp
         PHG72Yn2NTCmhxxopy0EH33BC4HkBaGFe4mXddUaew8uqdJ9YD5HOwoFcHOeLNEaDWMC
         r7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j29FLFU3PPvos/M6xBeZT5tWrNvRxgX7xq1kd2xix8w=;
        fh=xqKZlWSMwL0mK0I2Ri3+Zc/4YvZu3Qlf6uyn9Ll7nRQ=;
        b=lP/eZnZ1QzrkbWlgAKx1TudOEId8o5Dec+5eOfmL8vUBzlm82vSZKIxeTX3xh+/XBu
         oD1eCDwLgMZ2siZSypdlfTUD/trJWDoB/1Yhoqc6c2i1PjBu8MZxw/nTcx/bBl91HdqD
         byu/eRQwaBCad//bhuekyY+RnXr8T4Ssjt51G81P4MCLFl8DxXHKMO/oZcB4djfyfDUF
         4OqFWsPEUsqNKVCKs2MVc8IW7BPEQTFIbPoE8GtJ1qiuTSr+BOpmaOltTNB1hRPkasei
         NfcbKJPHikG0g7gqZXSm00VQ93ghBPdTogpRk1i3l5D6EweTVn7QGbuQNUttYXI40jGT
         9zpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772614430; x=1773219230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j29FLFU3PPvos/M6xBeZT5tWrNvRxgX7xq1kd2xix8w=;
        b=KffHlzLf6WMPHlRiYT5YVfz9vDCsLLczywDJCXSc0eel254pQpJTwzGelcGhhXmJAz
         shSvwAD34xsHDbk3WY0FQ8boh8YH8Pr8xKw54B3ndPAP58YsBWeuwiZvQ0g8GeA4C6oO
         7ixJM3OXOScAIoh5AQFPGSBN0mrCDA9hsshuyzRy6EbNaHUsLwuMuHMpCDgad+A/uDfP
         QTMQfVwHcnwAcK54JJprcwQzaLcWFkSFSB5Qq+D8VAOxzuxI7NAvVlc6TsGPbnII9tGj
         N2i1i+N0FKAiKBqgD6fo+58P7OYwi6uE3wmVmPnkBCy7ofC0dOEnEhh5wjj6XcoxyP7q
         Iy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614430; x=1773219230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j29FLFU3PPvos/M6xBeZT5tWrNvRxgX7xq1kd2xix8w=;
        b=VhJ2CmDDNZa20KAiKZ4gHWrVjp5SpWyMUbuzzbr2kOTtJVI+LeJIS/f68MbogywZjO
         /ZUEY3fKCpmr2kuAIrQYK0SV2RFmFYiCHfVPsNiDBu9Ori4L/FWS0DDhjMPDfD839e4N
         NKFjMmtQxnJeMlNTDFgGhrUpjhDav98XaPVvKWP6IvL8CS48ZjW6C3//74sZOU1rWd5I
         g6iwGOv5kFjQkTJMVMtesE5l5IvbmELkii3vSe5znse48h3oLfuqlJQDN10Ohix1ClQF
         GOjQIS6bZEKb2xRpii+FJQQMVAc1y/v8XV4VieZj/iWK7lAcSkLNPn7Ls9KfKF/cyW4q
         8FBw==
X-Forwarded-Encrypted: i=1; AJvYcCVSxkCuMRPjfw0s2Qq02piE68kiBrbieWTvXIVUJ2OPHCI718TOk4IDwslhieGmmRtrH5u3vq3sow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmwUtNisNPleCVwCL0L6xyLHB7BLfbzPcRChbpYOcP+UwRjeR
	sjjb9NUuLFN9T8woBxr4gbqdUyM/bB5cCSviJgqsIoBOQh24UNDHddV2S8cxPtqsV1CuHgaTbmg
	83eKLPCko8e5h+jVTHHV+ZilK1+zU1q0JhpI9FUjE0Q==
X-Gm-Gg: ATEYQzyBexO6djrvL9mt5cviEJUO8+MOthcGFbLeSaHT9mHLRRJVqpn7m0+vc39Uy6m
	QhdG2R876ZN7jtiMsphOxrWbukkQ2YWUtsr3cOaurGM6hsAnsaTMcdzyBu++5zmXd+GNSdzwtLf
	MeZDpSKkRkEvGQ/BCJa9sRFLtc+KiDxYJPvE5G3zN0WV+eBPHblVUP60RqDDMhThVao1K6xnAwI
	y1hj0AjA1L7gzXy9KlRbIPI+NuchIG9v4kEha8iKwI3VZ8PYzse6XHUTWgXL6sgyhDn/RMH3kEW
	e00POg==
X-Received: by 2002:a17:907:7286:b0:b87:322d:a8bd with SMTP id
 a640c23a62f3a-b93f11f02b0mr65154566b.24.1772614429853; Wed, 04 Mar 2026
 00:53:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
 <20260303-bq25792-v1-1-e6e5e0033458@flipper.net> <20260304-fantastic-butterfly-of-abracadabra-8fb2c4@quoll>
In-Reply-To: <20260304-fantastic-butterfly-of-abracadabra-8fb2c4@quoll>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 4 Mar 2026 12:53:41 +0400
X-Gm-Features: AaiRm50ufiiK0yXNWebTLHuETT9y1G6OWqIkNChKwnDCLZsvEHEo3p_IwvxLg7M
Message-ID: <CAKTNdwGz5Hr0jwd2-_JjzbTzgsidsWs2LAG8+LRMds=7duLKrw@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F2AE91FD046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43546-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[flipper.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,flipper.net:dkim]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 12:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Mar 03, 2026 at 07:32:46PM +0400, Alexey Charkov wrote:
> >            enable-gpios:
> >              description:
> >                The BQ25703 may require both a register write and a GPIO
> > @@ -74,6 +65,60 @@ properties:
> >            - regulator-min-microvolt
> >            - regulator-max-microvolt
> >
> > +  allOf:
>
> Heh, why bothering to test your code before sending...

Yep, my bad, sorry for the noise. Testing schema separately from a
common W=3D1 build, runtime test on the hardware and checkpatch just
refuses to enter muscle memory, but I'll get there one day.

Best regards,
Alexey

