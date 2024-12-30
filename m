Return-Path: <linux-pm+bounces-19836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64999FE38F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9879E161456
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210B1A0718;
	Mon, 30 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCZktviX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A029429;
	Mon, 30 Dec 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735545709; cv=none; b=HT953mupA8wjmiUl0zRrcVXLN0hF0+k9atW8N47VaSzsh8N7MeQe1WJ0kd8LDS5eGZ8Hm84kSiql5K7wZycGut5qBEgPFJSeJ0idP7Mt/Gxa0SO9UHOzez961iDf9ftrMz4tO2u04IeawPQG8KcOx0iL+wGXXnLHX/PVaw5f/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735545709; c=relaxed/simple;
	bh=O9PoAHErQR2KnT7INGvogE+M2TZhZCnyZbEu8H7Od1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trJizbiMRB00Dm71NokA1qg9RHeH0nnbcFy3q7INCDVt5ejHp2fBzx4COsrMLxQEmOWyos2bOEfe/NrWpmvBPrXbTTVMMm0tsuM0aK0wuC65TnpDhji3bpf5qUMu7R0kbcjTqsGU32FqrkjkxC13iXevIpmomMBwUxBenlnF71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCZktviX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so11767611a91.3;
        Mon, 30 Dec 2024 00:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735545707; x=1736150507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVqcRLSJWbwcYt3XcGtyBdDtB8cA84MCKgUW1EbTZx8=;
        b=BCZktviXQpbtsRD2VLMLy8S9L7/lh8fQnLfwEazVwXrBplqPT+qbW350Nd2qAdMFUw
         EJOTu9Injz+eNXDD6G9DZN8HuBXATHE2P7F9I3hqX+wmFbypTUDwW0OqddAf0b+m3bEr
         XkA++jBmt1w0KzNVbPkq3z5JrjFMRBGBREaEI9sMaGwabHTuSO7Isp5Oswz8Izil7Irv
         zieJGWKX40vzf/EShhMkVx4xOBxVNy5jtCbDzKLd+L7RlhhCAuU8N/UbWXVEikB/p3bh
         n4aYwhrQCzZn1cE5SImT0+Mm41tQ0gR5tmAb72lXIyJkX+ctOJqYOMzhSk6lpMX2R0IJ
         IMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735545707; x=1736150507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVqcRLSJWbwcYt3XcGtyBdDtB8cA84MCKgUW1EbTZx8=;
        b=R0W9aBrOFafDp+CGoGMhVPbDwgQA6x7AOKprB3pO9T8PfdV2L5TpQ4OYpRmiCUjgCj
         pfAxgNbSNeYuPM8Qx2QQWfg7wcWxQhFLhXvC3ZYBil0n8wgldezyNL0uwGpyHKEjieiY
         Wma0mG7BQ1gNfIn3bHzf8+P4MF2SvTnM56fqJXz5cDs3n3MPxzm1oTSSKbUjofCw6/NK
         OVjjHP/67DkNiiTpiQ7h1uovOZCxbsyDyIFOM430kgTO3Dy0q6DAiH2jUNRVAgi2s8bz
         DnHfDw8289qm4xBOEndmkZ7txjx1qVfly72DPZc6m+XnKhOUhBo/+7jsk0+IfNGnD1sH
         T57A==
X-Forwarded-Encrypted: i=1; AJvYcCUvGUaVxTp2LQma4oea5S3HnVpFK5fhax+hhUssfyjPM5DDnvd8eneXKhOk/xTbp0mE9nyeN1VHQByV@vger.kernel.org, AJvYcCVAV1tEOW18s0svXsv4LC/lgmuL3RI4xDxJEiGIdTeMUxh0gqSc2T2Re7fxuOR2/2RIspvp1+ip9MA=@vger.kernel.org, AJvYcCVB3gOtkZqFsXDJNwRpoBhmnXFnD68RXy63XSewcIhTqbQNIY69jrTXxElrQ9tVcxeHjlI6jrDsl6SUgWobyA==@vger.kernel.org, AJvYcCVir8qFhlC+d5S/G49Ajr6P1Q5ZPrIyyLJ27IqCz58PXoIZatjut77H9UZ5h+kPlUquLyRovKDkmUbINnoky+x/rSsiLA==@vger.kernel.org, AJvYcCWO3ap2YkGTVysc8m0rP8hG8ERX9iN55P3co7XkCjCV1avkHLhidd/Y9JpaMT0YLfSeEENRNIMJyirY@vger.kernel.org, AJvYcCWnMZxXCs8NS3x19yurZiPjYNERL5O5g9nFJBrMJIqSPT4lUcqDEXxuNellfOoLndQIP2vAmBDA04hhubXb@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOkl+U8BW56AOzf64iZP/WH3B2kRJBbupA7i+sVm1q7XAVoF0
	+YP4xKCzJt4LmwUYQ9HC+P2O1OTEnChv/MtEl9I3raKQkkPKt3OW
X-Gm-Gg: ASbGnctkDZny9Mj6bhOpQtP5OlRixPPVAH8GYjNi1eaJvJXJmLxB91tWdu1eZ7YLGZy
	4i9zvZG0b0t2aYQmMckdc9eFdB38CKW9KuyelZ/HCp1bpDdQEaiS7O4sBlNMJbjz9mZi04qlj7Y
	Xqq3cdz+b1GtR45TevmgvY8RMohFfJNgBgLihVKnLFSNwy/r22+p2eEc7OShzQirz7PIsMAlPCD
	4bwZk3slTB50ZjA6Guf+Lx36d3qSPR30m1r0N+XR+c=
X-Google-Smtp-Source: AGHT+IFT6+MQFqRHcdFz9mQ/DD3//GAwwRxOIzlDDnrve8D77GoT8HMloboONUjp1fmoganGx5hEOQ==
X-Received: by 2002:a17:90b:5208:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2f452e1814bmr54483386a91.16.1735545706924;
        Mon, 30 Dec 2024 00:01:46 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478828besm20067447a91.34.2024.12.30.00.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 00:01:46 -0800 (PST)
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
	krzk@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Mon, 30 Dec 2024 16:00:27 +0800
Message-ID: <20241230080028.141054-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <7fc6c727-d3c1-4c6d-a990-8caeb95c43c5@quicinc.com>
References: <7fc6c727-d3c1-4c6d-a990-8caeb95c43c5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Dec 30, 2024 at 3:28 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> On 12/29/2024 6:12 PM, Pengyu Luo wrote:
> [...]
> >>>>> +      - const: huawei,gaokun-ec
> >>>>
> >>>> How did you get the name?
> >>>>
> >>>
> >>> From website of Huawei([1]), please search for 'gaokun' here, we can know
>
> Gaokun appears to be a code name from Huawei for the HUAWEI MateBook E
> Go devices.
>
> Could you please specify which EC functions are customized specifically
> for Gaokun and which EC functions are common features used in
> qcom,sc8180x and qcom,sc8280xp boards? For example, the upstreamed ones
> like sc8180x (Lenovo Flex 5G/Primus) and sc8280xp (CRD/Lenovo ThinkPad
> X13s/Microsoft Arcata).
>

Generally, pmic glink is a subset to this EC,
common functions(slightlg different in implementations):
- Battery and charger monitoring; (drivers/power/supply/qcom_battmgr.c)
- UCSI (drivers/usb/typec/ucsi/ucsi_glink.c)
- Altmodes (drivers/soc/qcom/pmic_glink_altmode.c)

EC extended:
- Charge control and smart charge;
- Fn_lock settings;
- Tablet lid status;
- Temperature sensors;
- many other thngs (watchdog, more WMI functions, it is hard to reverse for me)

If necessary, I will add them to dt-binding, it is a bit bloated.

> >>
> [...]
> >>
> >
> > Check the motherboard, https://postimg.cc/V5r4KCgx (Credit to Tianyu Gao <gty0622@gmail.com>)
>
> The link is not accessible from my end. Could you please help follow the
> document tips referenced by [1] if this content is important for the
> overall naming design?
>
> Here are some snippets for reference:
> "for 'volatile' documents, please create an entry in the kernel
> bugzilla https://bugzilla.kernel.org and attach a copy of these documents
> to the bugzilla entry. Finally, provide the URL of the bugzilla entry in
> the changelog."
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst
> [1]
>

I am an amateur, I have only read a small part of the documentation so
far. I will have a try in v2 after reading the doc.

Best wishes,
Pengyu

