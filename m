Return-Path: <linux-pm+bounces-25006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29914A823F1
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B19D18996B7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38278255E26;
	Wed,  9 Apr 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HFtpw7yc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494725523F;
	Wed,  9 Apr 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199328; cv=none; b=UtKL+rjbC312OpUqF//pkgi5s3043ilIj/N9DznBbU8b5/pu8tTyHlsEI0Rlh60W4PLHT/eOAjCA0Op971yYra/QoB6z2VC4R1HyGULoGc1RJwgdiCekYza1Fbwb5u7vr7ODWUfOvZRxBDKXaSta8cAWhb04lK2yLee8Z5ShcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199328; c=relaxed/simple;
	bh=wF9y/J3VsbFPV5qg4NPTB22BV1bKOQm7AwHR9rufrFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WC6xWoM/+clb+fHne2vNaWmtUrgYMr4w4HV5vYUFf34FHzV2yBbwzkNky1tfJH5KdTauweOZevfVkv0WF8IzIjcdGySg7RTa8A529JlN1sF4FaMEjA0j/VQp7qsg5Nw7BRxZBqvdw1iQyZPoVoJ1QZigydIlpVxvPFOrLksC0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HFtpw7yc; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744199314; x=1744804114; i=markus.elfring@web.de;
	bh=wF9y/J3VsbFPV5qg4NPTB22BV1bKOQm7AwHR9rufrFw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HFtpw7ycizwyNIlZ69V7ZQTFYWJEb8s8ShFXOE0MSrAoLhkU7Bc7lVpw9LdQKM3B
	 dZum5cT/KmAm9OyxQEPC9S8rqYSFSJnFwVjaSMBLGuKPm6rQLUHxRJAzczJremNxE
	 U+MWNySyaEtUMwRYeaZqO4dUziEgO/3bHgMf/mRtzj8WOZ3Ty8w1drMC9WoVLxkVu
	 /xThGKRl0AvpJB0m5T1a4nlcBSOw6gV9qAZ9nh8mwUTnlHwwqGqt7Epes2eGlUmYN
	 iuTIOHm4vPcD22yVmABb9KskbP/fbdMaf2BgK4YC4UaTVkECmp43iOpvryLZ4lYzn
	 U9XfCkR2T1aKlBIUTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.27]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMY1D-1tjQxx0BwF-00Vncq; Wed, 09
 Apr 2025 13:48:34 +0200
Message-ID: <52aa52a5-7081-41ee-872e-f1728c06daf1@web.de>
Date: Wed, 9 Apr 2025 13:48:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference
 in get_rate()
To: Sudeep Holla <sudeep.holla@arm.com>,
 Henry Martin <bsdhenrymartin@gmail.com>, arm-scmi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
 <0558b7f7-8c69-4664-afc6-bae4fdc6f071@web.de>
 <20250409-merry-gay-lemur-8288cf@sudeepholla>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250409-merry-gay-lemur-8288cf@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X53yHopdPIDmGmiruirXCSOmP/kCyEItqusd7/5FHAh4OKeQZgj
 uMj+IcyDAW1kAG8RSKbkdC9EU/xw5sccS1CjSCRgFep2i1Ea6dUBwjsk9+NGFZkmfYW2Hv4
 ojiJtarJTJFcGOk9iH8+MRT56zZFe1RPyCh9XihM2Y0vHXkCM2yzIDJKK8c4iyBGZMndeuB
 tnzsytrwJCvG5ZmG04uLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:amzieSPgePc=;wvcCvc51KN9eWdRTJotmxzzuQqG
 yT/hPmcXnWfYGQ6JRQNq/rZkStx4JDeWcQloa4sOHTJj8HacXTSDTSUUQqUwdc3ATwAznubXl
 i8aPkdnuQMnPkwOmQIaOhSt3WPj38NCi/9ofLMK3tRFf/K4uJFszhHN7V6MW7DtLOlS3xpo40
 AHjGfR7UpUsCRU9TmQibjeskhWMwGpR3ZB4sS0aElolcbgejecwgGXEDyBZHYRO7FoaLs01Bo
 n+950hVskRLRuMgDtwyZ9HpJswXjEARZpFyj9uUc4VlIb6IKJfmc8Nju0nw3OKlQoZLENZ4xP
 Lse9w5H6bTOGoQxXN8gipIvhM1Nc4jNsGir50QgSCkqXvBcHLt6znduNd4jf7uXScztGlIMSI
 K1ruQZOyEYsWA5J4iss3Ky4b4SfIW1u2omUcB343zDa/kArYU4WKISZSzzDQBwfiE+Y/lUdG+
 Eiv/9WB14BaRGPFwPnbzVoqE88YTSqc874NU0kPIWdpsWWWEHo1GjzTcraoUX63AnMTDNDHw+
 IvyFvJWiA0Yruh1yyRaLj3Ltzf8Wp9VSz4FrFFSUUxQgvEWzyr0ozihABycXzxZsTjOZ1GBBl
 +LZqY9GhKtP4rTH6JATudwLSxM9UXhc+w5U18UbDOtgRItZMYTqFYtxiARjvtW05MvrTYqOYT
 1GY0hdlQYtbcao/BOI2GkdnAz1HmLq1U3yzlsEvUYiAsS7a79IYxcBCEE4YuAl00Isu4u7Z9c
 HEYtTlmEFx0Uk5hRlZ8QuWLu1Cav5POWid1KhXZS6Z71wTPz2LhEjwf4Ni0Y9KRgDSw/3myzG
 mtJdHH/RdIZ1ppMzrHmb2YxdD6or31yFusMxFvwShB1e4BW5qKPgxey7nrNNT16UqF1N/MRZd
 kxCQqDj0xJ2PqAWXFPM9aMz7rtrmOjwYhKuqL3x4HMKwvXmMa+h5CrQulM+jhwtvYXaVAupcF
 0VgmEdfipv3mijweHdmhSZ/Cd5T6pp0+xehb8e00bOQ+lWNjZTx/npaK29vFSohIXcSF+7Vw1
 K9Bs9YN3yuhN7clT4y3JpMeXcNNL0Yxu/QBzJfrkhWOIprqep9/KSf6kKDhrosLzkJ3w/p1kN
 vs0ZriStj9V5o42Hdpy4E6TnOzgNboo56tAN/ph9qFsf+yAMSNO7TqxQWSo3nfvehL8j+92AG
 aSZOV7XCQuVGzExMVdOIsG5F4RQa5mO19YUFcldvnpwO51nUaW3FUCVXcFpbO4EW6bTzfc6Mb
 ui4489CP4V2wn1NWVME+9rm0xG2yUIvD4X5nUDojQhEwXpGaunkT/M+olwwMgkWAEn6ouzFqa
 0H6yTSRIgszggj23Opz+8GGwTAuekFRWVis2BFR14MS4YZTppSBDPl7jYzZteSvVlxN/PxPXi
 SEOPyBRYNk1ujFUnvNkJqAKrUc1tLHAjFkWkgsSAjT2Ey9HO67ltZUEmbJFEgpyXTzgcYc44b
 s/+YgxmQ8vfKVyMMcm3g38urkiPht5xO2NZ+EpDI/d+IFUoohyqCyLPT6aFQLmg+Jqjmt9jlI
 9u2tkWCYPz/B+bOnBL0=

>> Can any other summary phrase variants become more desirable accordingly=
?
>
> This is meaningless, sorry can't parse. Ignoring it as others in the
> community are doing already.
Do you care if the term =E2=80=9Cnull pointer dereference=E2=80=9D would b=
e used in consistent ways?

Regards,
Markus

