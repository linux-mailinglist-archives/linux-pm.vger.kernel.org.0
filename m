Return-Path: <linux-pm+bounces-42089-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAGPCb5kg2nAmAMAu9opvQ
	(envelope-from <linux-pm+bounces-42089-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 16:24:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A4E87A8
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0A7D3105AA7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECD421A0C;
	Wed,  4 Feb 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="i1/6jcDA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F73D994;
	Wed,  4 Feb 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217962; cv=none; b=HDNSZZy85RxgIx7SEfmfpaqZuwvJlMZtI4v3ZrvjApbyjmeIx0y5hvE6/pvMBQEdi/RwLbKNrDHZ5L48VYXGRv+sCLMmNsrP7KdZVnzVTFkk0N9eHfPDrlotZase7dQcUeNSyTIrZdHAkxMNf/3QRvw+T+R81UKo3CJNoS8VHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217962; c=relaxed/simple;
	bh=AO46tXArkWBhvk3CGb7pT15KuJbMhPz8K7XwrkuyLSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch7r6oAyEromHRyZk/ZVlGVQO3Kr01N6eMnBfEsdKL0UTcFxhPTxJfA0eN4d0b8a+c9s53thIUAzLIejHh/cn+ofrBo6OzlxxxUvMEZHARfrKBQjNRaKUUM2q8oLZijqnJA5nqP3T4BDKKDUu5Ii6/hIyFTY+fZxQfK5WTTyI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=i1/6jcDA; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1770217952; x=1770822752; i=laurent@vivier.eu;
	bh=AO46tXArkWBhvk3CGb7pT15KuJbMhPz8K7XwrkuyLSw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i1/6jcDA9T9IlZSDz49+vF6bo3GcvmTqeb7w15djppJ4M5zp/ZSd2tJng7mjAkdz
	 GY0XRyM6BkFv7G78PGKFWUgiURj8FDfoFwWd9CGRZI9Vuu+N3OHPl3IC2XSb4E7+p
	 6aUNYz/ada+Tp+VaOR1XQxZQtHvwCBpDST+ko4Ci4f99lxE57pwGgG7gvcVADEudQ
	 6OW+QNnZo9/PcggIYfp5dm5WOO5Lrk3QNF0MT4f0ju+9s8jXbPcj3nAtikqZeJpza
	 Hi/CuLrJfFVUiwUQR/1bzRBPck7DMyRm73MQKiPalibtJbptMUtN5GS92mraSkpH1
	 aLCuHosSPiJArQqvnw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MxDgs-1vckPo23OC-00rN3O; Wed, 04 Feb 2026 16:12:32 +0100
Message-ID: <07164a0e-fff2-4e8a-baeb-7b5b6f730365@vivier.eu>
Date: Wed, 4 Feb 2026 16:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add QEMU virt-ctrl driver and update m68k virt
To: Daniel Palmer <daniel@0x0f.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, sre@kernel.org,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260203170824.2968045-1-visitorckw@gmail.com>
 <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com>
 <e7ddd671-6e25-4114-9d4c-21ecebe82ef5@vivier.eu>
 <CAFr9PX=heS=ywLCidd8o_BzS4TS5U=GA8yv7itzNFp5nuwf2XA@mail.gmail.com>
 <2a4ebbea-12c9-4362-aa09-dd3a7de1be46@vivier.eu>
 <CAFr9PXmqSv00Dt=fwwGsDcr8DgpELsa-X=beqazcQOJvxB0=1w@mail.gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <CAFr9PXmqSv00Dt=fwwGsDcr8DgpELsa-X=beqazcQOJvxB0=1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TMm81Y1BakMRhxpBZubPIT46VGbaQlqk/zL3Sg4UAbDBmqYw4sn
 +vIF6HXR1CS2oJOINz+s1C6OfXE4NL3x4ZjOhnUjljysPvLLyM+L5oZsoZ2Q/nEHjzWYIuf
 SZ/PMFGny1+d+GQI3xCH8CtqF8sSbxkB0+DFT3yoKrwWRShZTuhLxkBaFPEAZgGdx6WMeXL
 3TFKf3qOS+UM9vgDVaCPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:25K/C10vbLI=;gejJtD92ifegTQ4ulr1JzOb++vi
 6E59LMdH9PsEtt4Zbbiv1qXPtnWcKgstp4TstmkMoV6y5BBrHYTPhFoy1+/0Rtf24mr+ZUAvY
 m4BZpPaBRv111ZK3Ud5G8SozrQoFyTgCxc/5AwaRPFo7k57YPRrJH5AIoFMZM/wZsMApqcIQZ
 PdmhE/i1PGsDyx8b3bgSc91S1gJSOWWsQDJ/MROFDa9D6bxV4J8CEPHrlnD3X8LvJQ88rdmb5
 AqNezQaSTfj7/W9YnHFfxGdksgMS5wyvVLqVrEycQaRXm0XzB/u091mWGKCsTwO8eok2Hsjb3
 uHdPFMJPtYsi2wpK56NiHGaGt/RXbXNC2g5v2qUgxczboEkJTtB/HbTnHG8fQdNMbzvj2Sxw6
 FPXDd6iQIHXpHjHwPSMu5kOuGqDYZsl+WDDJmxQ+fsOUcXcSff1p2SPi54FBJB+p2lCY3GgSk
 8S/8cHCYHyfijIYE3GOjhbn3LRNBFvmG2L36/G4lT9hglq2Kj63IvLuBD/dIkAP2I43+goXOq
 sh1Gb4/WGBvA7X4zfFAPuLbX9VmN47eParUmzs+AfseTveFQrKgyJtdSbNiLg4jkZvpTwgcdJ
 Gdcwh8UhOEUnxuK8OhChRCQfwrNpcdn+7VX5bEXq7qf0I2vExduochy74SMoZOg8UhMcQkpKR
 Ts2cHEyP7lTwVKy/0e8g9rKmuI1pn273Sgwjs9EQere6ZBXFYDHqreT/zlokPh1krUkgNbKJB
 A+Qsu9v5rjeO71DmpkejvrGuMZs1+5yn7RmqDQnd45BubEMZD4C+ch6G2qYeMo4mFC1E6uAoB
 ZArwqpPbnj+g2FVYDcPAc3qGST+Y77POgE5CX+cIlHb6ypaL+CWgqCobDr2x6TSmMF0oYgg0S
 OUWVGZAcCT3QyDjRae15YdpVPTsxrDJiI49iM7y9TYnYb6KraeVzzEjwKE5YPjSygg+vqNftF
 EmSQOAlTinN7MCa1o7tlw0SiGTxGZSLWoxVShKdrmfl09AOWq9Dd5bIykmAz1e3e1Rmf8tVmQ
 6Rc81Zq2BFTIK7TmSNrTJ4VGqg9AjmLuMcCss8L8VyrP6ai6LXDbZhaT+IxYITVd94BQv716Z
 ekjK7SqbdRmFDyYe6BMvrVFwvKCKBPxDONIsbHJ7JBhVa3Kv/dTEC5XelCqnzq5rGnvpvF5bj
 ydgkKQLeZfwdI1YgZTAPOFWnV7JTv7/1zKCAJyvEpY9msVHVEZTAI3MnwY+xAJoGTG/+EmkV8
 J93bus4KPFD4GObYvjoT7aGzcLRW8nTtGQIv+xj/x3GGZMChjVUTegDdNQexgIH7gaZffjvkV
 tC6qEfyLWkKa5Jc+1NZ7jifyVaa0vTEC5H/LIOCPCUawQRpu/MnXLVfgxe3wlWi2gZE2SskLe
 63mPYrjlnhdPa5fffL2gb93bnX8+5ds5fCT/cbhsCXCo/eA2PaCFfRamxxxaQUln1W66qs0Ns
 +PSBtITuStqvsHtj7+ExpXDKc4nfEIVCPRRWD0W47AEeKZP+A8AhrwQv9b/G8EH8JrcXKGYfn
 eaK4nmfX2UC7UTkN5+NKRqU/8mcz5NMhM+L2A30EpxqW5MR1OncfkBfay+eYoxof5u47dEAMj
 7LRK0YRNBb05eAWSW2lXMTLGNzOjQ/6EupFeqXXG2sR0L8pnKYJm7AedsXyJtn7/l4oCoGuy6
 LLA9VDdgTnE3EXCIVQ1Wbl+ciZ+Xtn7erYVUWO8IdglqV35zXt9IAZI1wB59QFyEjEQDhD9Fo
 /Hcb3OkBnZF8wYhrDMdZaqd+/kSxrhasqLMlvfhL7F3u/caGLzBFPms4=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vivier.eu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vivier.eu:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ccns.ncku.edu.tw,vger.kernel.org,lists.linux-m68k.org,linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42089-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[vivier.eu:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent@vivier.eu,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivier.eu:email,vivier.eu:dkim,vivier.eu:mid]
X-Rspamd-Queue-Id: 6F6A4E87A8
X-Rspamd-Action: no action

Le 04/02/2026 =C3=A0 14:02, Daniel Palmer a =C3=A9crit=C2=A0:
> Hi Laurent,
>=20
> On Wed, 4 Feb 2026 at 21:53, Laurent Vivier <laurent@vivier.eu> wrote:
>> How to use it with QEMU? Do we need some changes in the code?
>=20
> You just load u-boot instead of the linux kernel. I don't think you
> can actually do much with it because there's no virtio support to load
> linux etc yet.
> But I have that all working in my own branch and now Kuan-Wei has got
> the first parts merged adding the remaining parts to boot linux
> shouldn't be too difficult.
>
I have an old branch with a bootstrap ROM that can be used to start a bigg=
er ROM, I use it with=20
petitboot, but perhaps it can be used to load U-boot instead:

https://github.com/vivier/qemu/tree/m68k-virt-petitboot

In this case virt-ctrl is extended to control the firmware.

Thanks,
Laurent

