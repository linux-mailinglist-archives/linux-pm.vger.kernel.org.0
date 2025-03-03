Return-Path: <linux-pm+bounces-23433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D396A4E731
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB221897219
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4314729CB58;
	Tue,  4 Mar 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCX1s3W7"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4529CB47
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105837; cv=pass; b=Q/HODCW3Iedcet02oP1Kl0wEtDCPkcoGQQYX8gTRAu7o6SlsMLMTzwdxCsXsikZREpCU60y+ay7R38AhJvo2MvVN/Rnv8SYgs9w7qqTMOjLeMpfuEamwdzMAnWDuZfsE7tjNcTNqogEztr93MB5eNRErs/+zcPlbsO5sCJPe/WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105837; c=relaxed/simple;
	bh=XNgWdH8fl5cRzt9ljpvgTEJNjZwPu9TAIUcQAUPpGJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skp9z6RTWD0WY9K1xy+dknFsEfQFNZTaUgzfO3QCmY/Vac8BeblyuftGo+DstcdOgtVoReoNe/dmcMnvx99HrLog8Jq6imWH22BwGYAq+BGCM6xdbtQvTposliydoKywA1ux2iQfaH/sIw03kYy34SGfNlprQU1o+ePn73/DAMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCX1s3W7; arc=none smtp.client-ip=209.85.128.182; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id E8FEF408B5FB
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 19:30:33 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FCX1s3W7
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h216dH5zG2k0
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 19:28:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 647294274C; Tue,  4 Mar 2025 19:28:22 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCX1s3W7
X-Envelope-From: <linux-kernel+bounces-541649-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCX1s3W7
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id D595342AB9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:01:32 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 70F262DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:01:32 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8981B3B030A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871420D4EB;
	Mon,  3 Mar 2025 11:56:02 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3F202C55
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002959; cv=none; b=XnqtQ+GWKvo8yW6cv3ktq4sL6fTxY5kDI7OYWt63BTFqN7T9Eb2xkl56oAYoE92J/Zzn+1/uOm9lW5qVQ1D+q5Om37k2Jx98v5Hsk1YfH4xWfl5Nbbjbugu8H12X3/Om7QRLm4s9cg7pq3YRbOwR2U51FUIv1EcZwslRta637hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002959; c=relaxed/simple;
	bh=XNgWdH8fl5cRzt9ljpvgTEJNjZwPu9TAIUcQAUPpGJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rx1I3SsJE0227n5B4xgi8UXBnp1ZQO5Wv77U3p9wNLDLB9YdxFJk6neYjcOyUWbBOsdNxKv/sVlUD5e0A95iduC3HJsXCilpwe02egz7l3qlfcHo5Dexxf8L3J0prAUxji6zpjOPuZaDkjqxWq1JeDXP7fIF1IwrLjrBZfkJlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCX1s3W7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fd719f9e0dso8363357b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002957; x=1741607757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XNgWdH8fl5cRzt9ljpvgTEJNjZwPu9TAIUcQAUPpGJ4=;
        b=FCX1s3W7gks/gh1gIaOYRXTZMnZnt5XYck4kneFLu1lY53SmOcChbVtjj/FYmSWOvE
         tH7XeRuCCxMQDvpvj6CIE2s35eMVGd3dMRELe4xJl3w4Ecw4tHdwFSYjicq7XMaZrbK9
         J3Zb9GnCK5MrgVENiax+Wj4CP4+30ULaKIoB7cVk4HVlL1UC3lOPeeK7/4mi2KDNPZon
         HakKlODddkGd/FkddB4b54NQlKJsWDeoMXTDS0mkYtmvypHOLx3QqKDx+hrdtAtWdmbR
         2rMFSIV50oWxtzECb6I3YOChrCr4tzRgYE+UMvGAthnElw6O81qqExbblEn+/LbCYvxU
         Y+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002957; x=1741607757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNgWdH8fl5cRzt9ljpvgTEJNjZwPu9TAIUcQAUPpGJ4=;
        b=JAW7kEMaVn83W1W3teRQtQyeLvdx1S8J6vCI7hjwcx4zwpCjah3fzh2L3toYIIbFO1
         flMYHb9ptf0SA99aYs8H8ard4d2Z9le2nY7gud6F4OFOzy6TNpcWE72kr3+pv1/FSpVe
         piTCFe/eYK4GruzMLh1j3Xjfi+lcMMnihVD4KPNuZBVCwgGauPyts6Id5BN+zGETl+dQ
         RjDAmTZ51VV6RVe/4P6kceiM98O12mAyJwo75drdBVEZ5QkM/3I1NC0zRQtTQoCjMUSN
         y72mbVbnhhtK51FLUf7nBiHhKh0z0nyeLkW+yh6iLRzMCCKxBwJBc6SmBD5sP1/L1/tv
         wYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN/RC2PWV+r7a/Y+OcTfWjoBjOQ/XtFTOWlTqeQa2ClEKiXtxcrE0fLlCnYVHCY4ajlQj5oIetRjNTgEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27TAg5UMDTl6Qf+vxpvPwV43LE7+yAdd4eg8/tDiD80P1qgqT
	QISMK/CYY9nUGf0/0dTGVKwtUzMkMJhSpC9taN/kINAuznxzvea6XF2Dz70V9UMI5uX3yQv/5Yw
	Q/rhjrSQPYatWME/x7jDSz60tReXGnJIy8goDL2ARRSwxtW0s
X-Gm-Gg: ASbGncsYYd0mj2ebypZ1ni8z76LvlslwRruP7gNXb+DXkbP7F84nPDx33uu/3yFPBrj
	CIBmXH+AEu/Z259MpCXPGkmFPu1pThnuiJGWKMYzWettUmr2IWbu3AhgR5zJgVo5RcWPMZs+v25
	5XMPh9IDa4iyl8/4ZGhdujcxASkLo=
X-Google-Smtp-Source: AGHT+IGX8q8UK5ca8HVl/UrYuKtJYKHT+VOk7Nc15oA5SjFGT6TC1WnbIOSec57WlAO7CIGV36a6PfFL7M2kit01IOI=
X-Received: by 2002:a05:690c:5719:b0:6fd:3ff9:ad96 with SMTP id
 00721157ae682-6fd4a16d0aemr115286237b3.37.1741002957064; Mon, 03 Mar 2025
 03:55:57 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5000287.31r3eYUQgx@rjwysocki.net>
In-Reply-To: <5000287.31r3eYUQgx@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:55:20 +0100
X-Gm-Features: AQ5f1JoaEzH0RILD_BxoqNSMy1juR0ec4QxtwfOG9M6tuXJbj4t5l5bWPbiZLn4
Message-ID: <CAPDyKFpo-Pn_4aUAwowQmNDDa2zEZ6hwJhAAzCfArzzdt511Fw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] PM: Tweaks on top of "smart suspend" handling changes
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h216dH5zG2k0
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710575.33577@1cWt/YwbzBt/iQdGCeFuLA
X-ITU-MailScanner-SpamCheck: not spam

On Thu, 27 Feb 2025 at 11:49, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> These are some tweaks based on
>
> https://lore.kernel.org/linux-pm/12612706.O9o76ZdvQC@rjwysocki.net/
>
> which in the meantime has been applied to linux-pm.git/linux-next (as 6.15
> material).
>
> None of them is essential, so if you have objections, please let me know,
> but IMV they generally will make the code work better.
>
> Please refer to the individual patch changelogs for details.

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


