Return-Path: <linux-pm+bounces-19874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B66719FF318
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 06:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C74188252B
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFE14286;
	Wed,  1 Jan 2025 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK30eRv9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB678F58;
	Wed,  1 Jan 2025 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735711149; cv=none; b=kkeVgI+fJhM+rtDIMCWN7zPg48s3+HGUC/F5eVlaDhKfr+YnkZJfd6YDn57vNyRvaplCf2ABwASXIAMERObNse5M8j+o7IHPjgumnHJE89JLD/gaOLVlHAJ61VVBE/K+fA8M//BCq9L+E4A4kembQX/btvg1+iO/ohGG8NPqlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735711149; c=relaxed/simple;
	bh=1ERfz6MYRyQC9T7JOUIcmI7il21I2EZ+euGNycX8pHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kh90sV54pNcf6lD2PPzn/idiWGDGRJLzRBJwUnHx3Gn5+vh7oCPz+iVNe0nauh9uuZxrfopdyo2wxJ6kFadX2XtFQBoQksg7avtY2M5/xGl3+uwcAge57hSfp6G8n7N018ChHgiFElyBcoGChMchgU7HKFhDWL1suDiNSDSPkeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK30eRv9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165448243fso169167925ad.1;
        Tue, 31 Dec 2024 21:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735711147; x=1736315947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxlkzERHMH6O41FvyQTnmiC7rDKDMif6g1pkU6AYpeQ=;
        b=gK30eRv9ifZlF5yeO0FpNmwLBxq/4PUPRXKRB2Harezf1/5G6Sxaz08A+y5ha0Ril3
         tPjD5kYn7pVH2qEuxYjylsGdM/ScrE1GPWw4GLgfNCcnUWCL2Rm9M5w8QyroiUvfprMs
         VmNt+Vs1EfqNUVPeeK7MrsyM5laq1iLVNz0GBG4ykSM07ZjxS5btH0SjxqB/huioJqJg
         Sy+VlqPMyIgoTke32G6+aXH80y4q7In2NqWs4nVFWe4Y/FM+uE35J0vajQjQNYURyrZl
         8ghitX/mDPpCAjSvE4U8fIoM81PZi48ZmkDr0YtzQ6wOjj7fdicbE1npG1fVM3Yd/5Ay
         9TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735711147; x=1736315947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxlkzERHMH6O41FvyQTnmiC7rDKDMif6g1pkU6AYpeQ=;
        b=AyfvSN5X0d8uCckPxltne0RNhvXkNJ9+H98GZMB8RnAJUJZ/1L6ol/M1bkq9OQQuTf
         pt1cFUlG2Vffj8OTZi5wLUiM3dDlnW0KNeI0tQmufccAHUZxfq/XBXu5uMN1crZpvjG/
         aiV9z4xXpph3ljePQc72WwfZ2uk615BqGnOc0yF0FW7pQETAhzUeaCLR2bcfH4wCpmau
         hRJu+ahzVMAQKPtlxuT7O0OCtfvR3HGgjuLUfhDgYKd0/680R42PNpYcDBpC8+v/0irf
         CR9Ye330KEzWBndoh4hGAHSZs7XOV6/xv1WOw9BF80mPOqe+233Jdd1L8YyWgdVLPwhJ
         RMvw==
X-Forwarded-Encrypted: i=1; AJvYcCU/A8H5T5+CMLGWVfVI1RHt3fbdR4kdnfz/NeZYilNwNMat0Kyp+UvFl47Whz4mVRLlcAzrB44NV9fBuwBgGg==@vger.kernel.org, AJvYcCUICweDMYsoOOBc2R6eu9PFChU0jtlg/mWV3LAXtaUJaAHYMA78nJhRRkpxKa1qpAyqaSn28mtUPLs=@vger.kernel.org, AJvYcCVqdoh4cIvkwaF00iRrpZYRknTwVkhqZLSrtOrT/E4OZJ8WXN1gp4WqDwYeiVOb3oCfb4U5JGxf47z44seK@vger.kernel.org, AJvYcCWStJ/ZO55vZUlM0zNQz5OKpU71nB2ICEX+SAiRe047/ButUnizVn6s0deVnb3Dmq+th0xNxSACf1XQt4iiZVLMksPa9A==@vger.kernel.org, AJvYcCWtmVpPkJyiE2zFBPD0GonnTFHOaF1t1Qi5/Nabe1PTx98/xUW4zX0HkhherGs+RKzGei/M6pu1DFvB@vger.kernel.org, AJvYcCXD4puMYIlbsIkOyYR8ws/hsJfGYOBQel0A5/V9bG3qDwyH2/FoU1Vk/U1iFxijvATi74M9Uu9EpVCw@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbbC54heIWkIafXNI/PeEfRPCD+IrVKieEmcDqClTLhZdTsyV
	7wZ2Czi9Z091zG+8kVYjH3RswjkMKkSxjIUQuupBI/XILrVT+nAL
X-Gm-Gg: ASbGncurOTylwPd15my9zwWth5GJ2ZnJ+hjTjd8xOnpajzB2nperXcEOdG+g/HOppHJ
	k5BTbd/thuzeM+wOZDjZkZJH0hmRBMmLzHgnvq6yyRA7YLeNRdFO/W/OlRQh6a4jepphsQ1IL0u
	pD7hENDIFozjH2WNLLWsxfOsjytET7dHAsiJIezcGKmMYrbA+NG2Pd51BS65gvNiqB2sypXNuod
	vI/sADJAOWEwTxwPHu9nKwNmlydl2PGEF6pBTYAXis=
X-Google-Smtp-Source: AGHT+IFaaIyUWgZ24rB3hmAOUX8zPA+G1PMHHz/e1QmhclfDDXABnWyBle8Zo2odWFY/pwPLmQdrVQ==
X-Received: by 2002:a17:903:24e:b0:215:5625:885b with SMTP id d9443c01a7336-219e6f28552mr636262665ad.52.1735711147068;
        Tue, 31 Dec 2024 21:59:07 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9716b3sm204396595ad.90.2024.12.31.21.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 21:59:06 -0800 (PST)
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
Date: Wed,  1 Jan 2025 13:57:44 +0800
Message-ID: <20250101055745.357081-1-mitltlatltl@gmail.com>
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
>

[...]

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

I created one entry, then I got myself and the entry banned, :(
I had written to them to explain this yesterday. No response.

Title 'Huawei Matebook E Go, whose codename is Gaokun',
In this entry, I explained why is it called gaokun, and why gen3.

> https://bugzilla.kernel.org/show_bug.cgi?id=219645
>
> Artem S. Tashkinov (aros@gmx.com) changed:
>
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>              Status|NEW                         |RESOLVED
>               Group|                            |Junk
>           Component|man-pages                   |Spam
>             Version|unspecified                 |2.5
>          Resolution|---                         |INVALID
>            Assignee|documentation_man-pages@ker |other_spam@kernel-bugs.kern
>                    |nel-bugs.osdl.org           |el.org
>             Product|Documentation               |Other


Best wishes,
Pengyu

