Return-Path: <linux-pm+bounces-19865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14C39FED83
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 08:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229913A2B35
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75383188920;
	Tue, 31 Dec 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gral3VnP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2A2A1D7;
	Tue, 31 Dec 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735631158; cv=none; b=uAygSjvii8Ur+xA8iwuoAou9sPy1AnzMrOVb8/Ocwsn6q3CryvrdBgoICdv8wpXOooghXt9UjaIn5EaoiK4hvu41Fzc1lY14ib8IBEsD8uYIfPy0M5jPwHRGoviU9ArThdx0KccFZWQGOZZq14eDdoxi2FX0EN98atwZ7e5ocYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735631158; c=relaxed/simple;
	bh=ne8KKd1Ox77CuqbmX1HxrqiMYFGXITGbKeXrfPempyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5AnYZttueqouBS/BVxlgLbzKhGo/v9DAsgQhHE2d5CR8Xc+9Zz497Wba2AXrrmS0myYXuLOyqJjz108xgYQFylyrP6YeCXuC8UwaOArGfbf3apqFdODCc0wPeCJmAeI8hA/JShadlitpRq8HuUZbPWYX6QF65hmGcrOa61AuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gral3VnP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21669fd5c7cso131898885ad.3;
        Mon, 30 Dec 2024 23:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735631155; x=1736235955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pzS8juRQYh7y1FbB7XhfHYOtzhl/kNPmT3ZX9KxQL8=;
        b=gral3VnPPS34tMpmNdUOQH+2s3ke4Ux1CJMKxER2ZLrbbSePx2OHTQGSvqxWiLSL/z
         WkuxZO8fD2GeyDeoaj4n1+T39x+3LcmATNGn0dzDJ7mzzf88XOY0gqdImbZti3wB+jT6
         7MzUCsKGG6gZzIGINJUf7J+saBTyTzFpyBX442HTxMjk+ntwhVdo5mf07JMuTZaDU8nz
         reLPdtpiBNp76wqxj1BldKE7z2tYiM5JQnR3NSszS0/+GMxfiO3Y1BbS4nb35+v3uuPG
         lZjB05+H3xsmCwNfTDumvGBZ5fKHFQC4pD0Md6BdAAwEOyj8ZSnfDz9p5gXw5OQoT/Rj
         6Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735631155; x=1736235955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pzS8juRQYh7y1FbB7XhfHYOtzhl/kNPmT3ZX9KxQL8=;
        b=lQ0Wv6xHIUVZ+NJcTCLP/BKSkdPjyXwV3QhZxtMWGRR2iw3n0vRb4pdIxrA856cUiv
         Ht9aWBH1A4dyT/6sSYM6eYJJgXrcuhS9kr6T20xT8e6OeUHAMQhZHASVrppFU4QuLSRM
         vYD4+qyCQdqyPwJgXCpf8HI/vcxSBog5jCUKsW1/ogUK2sHLl3UGLyA67n8KHki62F/+
         Zl4d3r1G0DS1Apydf7ZvXtwbyHEARuCfycpFXFBPhsnkS6VUXjXYdnRjtiAymGC9311Z
         SPxPt+2XxPEUQa4vF2TVLttGxDB7G7iUp2PDzyVHanyxGAHzmKN2vPVGUrPTQ9R4QDWM
         TmeA==
X-Forwarded-Encrypted: i=1; AJvYcCUe9tsR7fq6CIDThfBvTdiBkWi0FoGnla4hIeFLUcjDV/BR49FMbLuj2RULvmVB9MdPHr2KE1PJPGM0@vger.kernel.org, AJvYcCUePZ+LUQFz7xJ/fR2oc8CHR1fCrmE4rzumx4LgP+2OQPmXEkdKcALxbkmOHpraDGVcwKpYHnwWGRvd0FJJ@vger.kernel.org, AJvYcCUhFl7v+QuUm3PTocIomGm4fNBc4QsCnUnal6RHJwyP/Hei+HF1Xlbi92yLBPIRU0So3oEVU2MXhHgbX37zKg==@vger.kernel.org, AJvYcCWl4D/5XxZoyoonttBkGp3PNCIV3rYf84+C/samZUgynVul8o1a+5mt7R8ksa0ywx89wwTHBO4Clrt/@vger.kernel.org, AJvYcCWr62/DjbF0MIzwazW8PZHbOWofU6cQV36lFcK3OO8KaxmOAAysA3Bcw5tiLY35WOjcaw6wLUcG5oaKuSIXG2ykqpUfVQ==@vger.kernel.org, AJvYcCXzIEN2uu+sUrTJGGwBxSjswpURbigUEZMRZ6LjQmOPcLsFe32c63GNhM66p9H+kQUPoYQQY41yxN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwEGss9g0x8GxWMWeOof5zSv5QiQiL7fV6Rq9rpwwn6KLK2eJ
	waSNWAyAhWk/7p9ClwR5W/8Umrhx9HjFWqHbUEsl6hyladaFXOCR
X-Gm-Gg: ASbGncv1II6gjIe38hmhDvh9MnxnxmVNreQ3rrKIvvb4+AKZJiT5v6q3nZ0DFqy7qxA
	ieditE0a29H0nc+kl+kMeu6M8IlW6mlbQkHwugnKgafUTJvlDFkxKql7wNMrYs0KeorGFwjApZT
	8BqJZJZCUpGsGiC7A/IkiuGahRQsD2OQk8GAHTuzwhcOnaBYGkAvSvAs8ktpLEul/0S33sQHA/g
	1bZz+fNtynIDZOjdLEXkoqnGgoJWOn9kcwvBr+z90k=
X-Google-Smtp-Source: AGHT+IHgiEOvR/+eBYeESBUMbYmnH2cck7IbpwCPE5DLcxeC+vKdjNFF1+pfeKCXg/VxNRHos0A0Dw==
X-Received: by 2002:a17:902:d588:b0:216:239e:f90f with SMTP id d9443c01a7336-219e6f2f01dmr635340735ad.37.1735631155425;
        Mon, 30 Dec 2024 23:45:55 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02b27sm188270185ad.276.2024.12.30.23.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 23:45:54 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: quic_aiquny@quicinc.com
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
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
Date: Tue, 31 Dec 2024 15:44:36 +0800
Message-ID: <20241231074437.239979-1-mitltlatltl@gmail.com>
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

I mentioned I rearranged it to optimize it. In a EC transaction,
write sleep read => write read sleep, in this way, we sleep once a
transaction.

Please search
'device name + acpi table' on the internet, someone dumped it and uploaded
it, in SSDT, check ECCD. I am not sure if huawei allows users to dump it.
So I don't provide it here.

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

You were talking using a macro to inline the varadic magic sequences, I was
talking defining macro for every constant number. If so, I got you now.

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

The main point I am against is hiding the data type, in some functions,
later we assign req[some_offset] = val; That makes things really weird.

I prefer to define all magic sequences, like
#define MAGIC_SEQ_1 {0x02, EC_READ, 1, 0} /* padding with 0 */
#define MAGIC_SEQ_2 {0x02, 0x68, 2, 3, 0x5a}

Gathering them makes things easy to manage, but I doubt if any source
file in Linux kernel doing it like this.

Another one alternative,
#define INLINE(REG0, REG1, SIZE) \
	{ REG0, REG1, SIZE, [3 ... 2 + SIZE] = 0} /* GCC extension */
/* or just */
	{ REG0, REG1, SIZE, [2 + SIZE] = 0}

u8 req[] = INLINE(0x02, 0x68, 2); /* Creating it */
/* not sure if we can make tricks to initial this in macro */
initial(req, 3, 0x5a); /* initial it */

Best wishes,
Pengyu

