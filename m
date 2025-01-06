Return-Path: <linux-pm+bounces-19981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4B9A021A9
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 10:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBC118852EE
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9D1D90A7;
	Mon,  6 Jan 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6GmsdfZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4E1D7989;
	Mon,  6 Jan 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155320; cv=none; b=nNpyQnkCMEbHYX33Nxcp12mSUTr267PCNlijC0sYiV3tUJxezmq3O769qv25x9arMBiD/u7sasjszaM4yGe7gvff+qMHvarYATatVVXXa0sHOAmXGg2Mi9ZcHoydkV5KrEg9Cs3uHomntCz/js6JYO/GqOwjD5fHfqgDsGf1ZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155320; c=relaxed/simple;
	bh=1ERfz6MYRyQC9T7JOUIcmI7il21I2EZ+euGNycX8pHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJcbDvPo5Rhf9R/rK4/zeSYuFjXgnVD/97uUKjqwE6/dEp1XrLCP6lbQRToXQlru0gZXFpREO1qPQ2b6cuxaoNAZkEBoGhOIZ4HYYbD3NgtMjlUcvuLQ1n6MlDz6bF9EBFsmvzy6ZyRhk6omWIxY6TiJgmkwGGrEz/ZBvfx//kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6GmsdfZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216426b0865so197143965ad.0;
        Mon, 06 Jan 2025 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736155318; x=1736760118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxlkzERHMH6O41FvyQTnmiC7rDKDMif6g1pkU6AYpeQ=;
        b=E6GmsdfZfuCXjnGbEyafXTszkP4OWp9rU8iNlR300ssFq0XVAntMRRFeX9ZxiiGX0k
         UYsJZPhyzK6obKqGzSK393qEeXWSVJS3htJ3hfoRDw0ksdJGPp8Sfs54KNC9OPJ21crE
         sscBZGIV5ngXmbtu+bQFH3rZeL9HOowOR4P+WhvAAsYKoVimuJO6J1eK4FfVpmRUYRVr
         l3ciIm4fv91Q+o0MkjUAcn3cIQLc0ycWAPdrdGfABPFmvFlfi7sK5dHwFF8Z9dwgVjA7
         6KY+JZuE9mWipPWi+HzvZuJ5As8qd4K6DHbu8HTVdNvAM8M5Ax6d9JT317XkBlbx9K1M
         3Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155318; x=1736760118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxlkzERHMH6O41FvyQTnmiC7rDKDMif6g1pkU6AYpeQ=;
        b=pb6isiV8WX+StWs9JFbYvkondAwx0VRor+0Y9OjAXa3/5CEAY0/+zjZwDYDCCMGmtH
         5TAWjHGtkUL47MdSF2QZoOoSamyu97PR2nLs4E+k/Ts7rGhDnbT63HVUZDxUeDWBod1Q
         zUbajJHFEsEGX8mAzj0oscUbqhCHBWcWoMjxqxauTVp5KH6jCOLB1+idYRgB94sHYIEp
         B9wu9UAAwNzfXFyegbESyynByGPxVCHqQXXzQX9D3A2BG91N56GcMf9A9TytcfY9mJbD
         7ogLutEHPNvTa4AaB8riiTF64yYoQSIovBld+RpeuzK6roVCaY8YVgKl6yMBm2leJRvl
         SKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf9P6CFsLsJdVvwaKpwedz5CzL2kai0cV7ELFq+Eyb/GQCCdzcnRQR/y0prlnxtJzbEQlazOummAz9@vger.kernel.org, AJvYcCVskQaTsw+pm4sYEcWXTjqouzWv06Bb4ILFfO0o7K2HG0XNunt8ke3U/Eaq9KZNAFKcGJxCn/zhew0=@vger.kernel.org, AJvYcCWDMInTatkcM64qjhj/WIl5lsqXYhPt5ehhsa8km5iflJKfiIujJ0UixhuFXpY6b+IUeABA081pZ5dNaYDaWQ==@vger.kernel.org, AJvYcCWJRPbgH/G/V4YpniOUSMfRsO6m/qWru8nx2k46z07xjsYz1YT8NIRyxTHWC2RFUtG6amWyjlvquyiL2i87@vger.kernel.org, AJvYcCWgy5X8mWTsiVktFxJShXk0h/drBr8cMeWTR23pbit8jkAuJTT8EKGyuLwV6gZpt9MLCxYvYAVLTUjPsTdlmILPFdw5NQ==@vger.kernel.org, AJvYcCX1IOzRPBXvP5mZjmtW6TAMvWmO+yKWfXn/IjMUWGBp3VxnJ1od9RYhTmcZN5QI52WR2ok6pDsjlXPW@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG7oeyj6tvOQqXXFak9/Io01rGltQWHI7KkCHPWHMMarsVM1e
	A5JjaW9ptqa7m7CynIwLPEhdC6WR1iWl3mdROWkf+pdb4SJ5g30G
X-Gm-Gg: ASbGncv6lZfTftF2NPjgheQEIrh/U0SYz2j3yif8SQGElas3pLHWbzizOtTEjL5b1Eu
	AnFw0WTJ1bE4I/yMhjV40T5IzGeZcpWKK6inHdLQuSAYs5Cc0HBFbL6xGwJu4I1O7vD9p6O36cO
	MPlCXXrSqc9I8f3jMzgZg/U7/5QO7qqMU49AC8zVNdT0DRPiIPIrRmFJRk8zZZbGJH5tYRaZebT
	eUh/TZPKVvT2IYGFr6dnYJfVueYOO9MkmbL9FXTQ2uOTN3EEUXksq4=
X-Google-Smtp-Source: AGHT+IGXi8StYEb75Eg6Rkljy5nI7Vy5yRp7C2szzeFHsg3az38XaLogelqi1TMQsp13y4MetIR8BA==
X-Received: by 2002:a17:903:2306:b0:205:4721:19c with SMTP id d9443c01a7336-219e6f1448cmr720559455ad.37.1736155318139;
        Mon, 06 Jan 2025 01:21:58 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842bdfb5759sm24173817a12.51.2025.01.06.01.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:21:57 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: dmitry.baryshkov@linaro.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
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
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Mon,  6 Jan 2025 17:20:27 +0800
Message-ID: <20250106092028.250715-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <h4icxzxk5fzgkdhhk6disrervqmb4dqe3xlc432k7pgyzsk77u@pyfrrtyjslpo>
References: <h4icxzxk5fzgkdhhk6disrervqmb4dqe3xlc432k7pgyzsk77u@pyfrrtyjslpo>
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

