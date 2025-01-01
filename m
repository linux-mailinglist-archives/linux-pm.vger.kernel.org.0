Return-Path: <linux-pm+bounces-19876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D99FF3D3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3770B1881F92
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F91C68BE;
	Wed,  1 Jan 2025 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZvZjMIg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868044AEE0;
	Wed,  1 Jan 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735730955; cv=none; b=hKqsxpHdhDCkYFXgh7j/TqSClGmOtM09aCjnCsm5c2SlXHTjPMsYGOv7PIOJBN+ZG1qf4GKpRf98k000LN2bh/5IutuT1Z/EdoEnSq8wx3UTkru54BW6zCzkHsDCDl+fyudBZuxcBn0Cjn4IKCIYZJsJNZ6s2pj3UUuZLzfpDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735730955; c=relaxed/simple;
	bh=Vt8VaSm2xKXl/IjHPEfN4f+dzv63gVPSkwjEE3RIjAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnkIZHTiOYiC0kvcTuJmk5DepXxxQg78vvDTjaos2srx22MfD7HU7u3RfPOE70r7hOItHHxBXLubXAT9Ja8Id+efvIts5/w6rY15225MaCSeLfJDFhpz13anWhLA7wyKWLVZJ1Tu7WMtKLhCRdDsIfdsqd5eIjnUw63iujBDBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZvZjMIg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso132807215ad.3;
        Wed, 01 Jan 2025 03:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735730953; x=1736335753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euxpDIryIx8z5lHOO5QRU02pYec1l4jlz4vtdy7mRWE=;
        b=AZvZjMIgWpr/1plAJhEadzbTkddF7XR/tGSvuFy9DNloJeh62uq+ZOjOLnyyGXwefS
         Zh+rzI61ddel+LhAoZWvP9W/aFo2BRwLvx2vnKSi3/ClGAwVJUzAm3ZxjQxDY6LZEj/g
         NBT2VOmY0oZtioub8YyyIw+Aa6yyEWHlcu5JZE5ms5CCx6eVDolVItySA0rQdf/b3EUH
         lt/6CCri1H9YoO6aRkENDl+P8pvLaKEcQGBNqzEpmBiyiIqgAaAp+3dsTvOVTsHbqyL3
         dBSRQiC/wA/rK/cq0NCnuo6hT7ihutx9d9f0ZNMjmtgJYllvQkSa3C5KMZKoKtyZ8XMt
         f02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735730953; x=1736335753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euxpDIryIx8z5lHOO5QRU02pYec1l4jlz4vtdy7mRWE=;
        b=jb2yl7G51qeJd0b3af1bKix4EyunNwI7BCWsYbqjrKaWfMi4JWq86rpGwiq6kXp9Nb
         9+UGn/cJQAdlDK+nT4DWdHBc0mEQlBOpQUvuh8x28F0iBVbQnU1RydyJdIw1jpQ1RdAq
         0bmESX6dw6Fb8PKiIPesGaNRs+zPTsxZE2R/uxZuO56xnT02R/uEcdxVafbeNsxMpc1k
         EKK2OLuBMgMgsELzzbjsn9CJswvXd3E/2QE6VJjPXBXwVQhEHnzLCYsp4X7XDOC2pmLH
         b8vx/ayj6ghazALtZOlG81UDeoscoYDBT/fTwd3e7pSMgt2mAM3Di6wh2JNw59dhRasC
         TJSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Xu04D8tCwUsfXCnu0wT8kVN67Fgjz7ouRKTvO0hKrQkr0cSbbmLyXd3D9zNqRcHTSENfusO/FKQDHcY2@vger.kernel.org, AJvYcCVOZVtbIlNcHwMpYUqGmFoBcVbkYsiSwhmKx3SYEKI4NGrZYg2p43e6XI1N+gbVJeiMYo/YG09tjjvB@vger.kernel.org, AJvYcCW00YPVLDuHwNruv519LxogADUAVXNF22lQhUwFadO9+fDYej9+bUlOZ+Offu2bL29PgEcMAJKAD/Lwn6j4JQ3Q6bzsPA==@vger.kernel.org, AJvYcCWc8O8NrjnjOeweRatvlcC+EK8krxYZIe//jVWfpg64kKrnXxoH8Rj4SW8xIsfE7E1ak9HDkdr57n0ntD0LfQ==@vger.kernel.org, AJvYcCWu2JTDhJ7NrTnYNoCYfqjmDXVE0Gs3QzVtRHdwyUn6omV2Vk78h+E7ZO88NPJLegGGumQwWbUW7EOR@vger.kernel.org, AJvYcCXXXP7dhZLpSS9ULgQe9ef4vdSPVOoA8VEtdFDfq7HBMBU0hDs4jDh1tR1ELlPJc3tJ7mDhTp9z+tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwqguxzNi00kLJP34CPDQi4aHdptjIrmgIkTBrrMqJ326hA9x
	fzHUQ1j1v2K/icNRWvxGbUjgCY+W8qzp/td2tDePrmMcEXFe489Y
X-Gm-Gg: ASbGncsupa4s4rb0NLQIJD0SqaDOH4ab4gsu23gpzbtUFYbAgPuPq5UybpRAccGs/Q+
	3dYAqawnG+Za7JiRtLP62b9yFJ3TitukY4p2krwsng9UEFZYbolwUnKXMvZXr1gbWHpgBeeiFha
	8qhBp4WzvCGSoJyt3yjob9TACjhLBeLBXlfbwUKOxwszrBdo6z5OoSQTg7MIdab5/vtSInnWiLY
	Ep/YVU2M4lNZnYe4IJ2j4ehUfN63IMEFGzRGikA1Fk=
X-Google-Smtp-Source: AGHT+IE4ci9i4LlYVrTe/BgBnCkk47pplNsAFc7EwOX4peUE02159UzdkhTssv4+cKqgAyQ8IzvD4g==
X-Received: by 2002:a17:903:230c:b0:216:1543:195d with SMTP id d9443c01a7336-219e6eb3a5dmr561048665ad.25.1735730952590;
        Wed, 01 Jan 2025 03:29:12 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdd88sm204025375ad.122.2025.01.01.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 03:29:12 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: quic_aiquny@quicinc.com,
	bryan.odonoghue@linaro.org
Cc: andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp) EC driver
Date: Wed,  1 Jan 2025 19:27:54 +0800
Message-ID: <20250101112755.417954-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <1dff7a78-1693-45d7-8ee3-357b33848595@quicinc.com>
References: <1dff7a78-1693-45d7-8ee3-357b33848595@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Dec 31, 2024 at 1:00 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> On 12/30/2024 6:44 PM, Pengyu Luo wrote:
> > On Mon, Dec 30, 2024 at 5:04 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> >> On 12/28/2024 1:13 AM, Pengyu Luo wrote:
> [...]
> >>> +     i2c_transfer(client->adapter, msgs, 2);
> >>
> >> ARRAY_SIZE(msgs) is suggested instead of pure 2.
> >>
> >
> > Agree
> >
> >>> +     usleep_range(2000, 2500);
> >>
> >> Why is a sleep needed here? Is this information specified in any datasheet?
> >>
> >
> > Have a break between 2 transaction. This sleep happens in acpi code, also
> > inside a critical region. I rearranged it.
> >
> > Local7 = Acquire (\_SB.IC16.MUEC, 0x03E8)
> > ...
> > write ops
> > ...
> > Sleep (0x02)
> > ...
> > read ops
> > ...
> > Release (\_SB.IC16.MUEC)
>
> Could you please share the exact code snippet that is being referenced?
> I'm a bit confused because it doesn't seem to align with the current
> logic, which doesn't have read operations within the same mutex lock. I
> also want to understand the background and necessity of the sleep function.
>
> >
> >>> +
> >>> +     mutex_unlock(&ec->lock);
> >>> +
> >>> +     return *resp;
> >>> +}
> >>> +
> >>> +/* -------------------------------------------------------------------------- */
> >>> +/* Common API */
> [...]
> >>> +     int i, ret;
> >>> +     u8 _resp[RESP_HDR_SIZE + 1];
> >>> +     u8 req[REQ_HDR_SIZE + 1] = {0x02, EC_READ, 1, };
> >>
> >> Could it be made more readable by specifying the macro names for 0x02
> >> and 1? This would help in understanding the meaning of these numbers.
> >>
> >
> > I really don't know the meaning of master command 0x02, 1 is the size for
> > the data_seq behind of it. There are many possible sizes. It is not a good
> > idea to define a macro name for everyone.
> >
>
> Perhaps you didn't get the "arg..." magic here. A single definition is
> sufficient for all sizes.
>
> >> Also, please ensure the actual size of the request buffer is handled
> >> properly. In gaokun_ec_request(), the req is passed down directly, and
> >> the i2c_msg.len is used dynamically with req[INPUT_SIZE_OFFSET] +
> >> REQ_HDR_SIZE. This requires the caller to carefully manage the contents
> >> to avoid memory over-read, making the code difficult to read.
> >>
> >> Creating a defined macro can help you avoid manually defining the size.
> >> For example:
> >> #define REQ(size, data_0, data_1, args...) \
> >> u8 req[REQ_HDR_SIZE + size] = {data_0, data_1, size, args};
> >>
> >
> > I think wrapping like this is not recommended, see '5)' in [1]
> >
> > Best wishes,
> > Pengyu
> >
> > [1] https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl
>
> I believe that the consideration of namespace collisions is a valid concern.
>
> Some examples can be like have a naming pattern as well:
> /*To have a name pattern to reflect the size like reg0/reg1/reg2*/
> #define REQ(variable_name, size, data_0, data_1, args...) \
> u8 ##variable_name[REQ_HDR_SIZE + size] = {data_0, data_1, size, args};
>
> /*u8 req1[REQ_HDR_SIZE + 1] = {0x02, EC_READ, 1, };*/
> REQ(req, 1, 0x02, EC_READ);
>
> /*u8 req2[REQ_HDR_SIZE + 2] = {0x02, 0x68, 2, 3, 0x5a}; */
> REQ(req, 2, 0x02, 0x68, 3, 0x5a);
>
> Please note that this is just an example and a suggestion to avoid the
> current manual variable pattern setting. The final decision still
> requires the current maintainers' agreement.
>

I am gonna do this, Aiqun(Maria), Bryan, any suggestions?

/*
 * for tx, command sequences are arranged as
 * {master_cmd, slave_cmd, data_len, data_seq}
 */
#define REQ_HDR_SIZE		3
#define INPUT_SIZE_OFFSET	2

/*
 * for rx, data sequences are arranged as
 * {status, data_len(unreliable), data_seq}
 */
#define RESP_HDR_SIZE		2

#define MKREQ(REG0, REG1, SIZE, ...)			\
{							\
	/* ## will remove comma when no __VA_ARGS__ */	\
	REG0, REG1, SIZE, ## __VA_ARGS__,		\
	/* make sure len(pkt[3:]) >= SIZE */		\
	[3 + SIZE] = 0,					\
}

#define MKRESP(SIZE)				\
{						\
	[RESP_HDR_SIZE + SIZE - 1] = 0,		\
}

static inline void refill_req(u8 *dest, const u8 *src, size_t size)
{
	int i;
	for (i = 0; i < size; ++i)
		dest[REQ_HDR_SIZE + i] = src[i];
}

static inline void extr_resp(u8 *dest, const u8 *src, size_t size)
{
	int i;
	for (i = 0; i < size; ++i)
		dest[i] = src[RESP_HDR_SIZE + i];
}

[...]

example:

int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
			     size_t resp_len, u8 *resp)
{
	int i, ret;
	u8 _resp[] = MKRESP(1);
	u8 req[] = MKREQ(0x02, EC_READ, 1);

	for (i = 0; i < resp_len; ++i, ++reg) {
		refill_req(req, &reg, 1);
		ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
		if (ret)
			return ret;
		extr_resp(&resp[i], _resp, 1);
	}

	return 0;
}

Best wishes,
Pengyu

