Return-Path: <linux-pm+bounces-192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896E7F81FE
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 20:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E5D1C22583
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514135F1A;
	Fri, 24 Nov 2023 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ol8BB/KH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6352139
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 10:59:33 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d8029dae41so746320a34.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700852372; x=1701457172; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82KAXx8prioxlVSYKLMBO8IPdtBCdxAO6nSEIEEsI5g=;
        b=Ol8BB/KHbI5IXn9BlP2BWgNInu2T0G1NPhV54O/GUwGmJFDzwgwNHFk7f9n4gQOHT2
         4zwwHM9pxhJ7aQEXtmxonh3Ex8WhhJOFsEZNe+JyLAQShrDR0ZFAMh9UuikcE8/NCcbU
         2T6yaelF4j6E8mtcGlc5BMP0fZ4SJtUsROHiZVPblHmrNazk+4sc1Ll/EGKwr5abiVVZ
         K23OuNfbPaCNsYuN/Da7w8Zzz9jb6FLsTaSlRg1Y1q8aTS9FcYIipxQEn7Y31hd+FLQN
         oIGHIbPU6Df+97WlYX/HQuLAKpn/75IYpnp26ACw1dR+kEHamiy0motx0nvgUdaLU3TQ
         8xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700852372; x=1701457172;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82KAXx8prioxlVSYKLMBO8IPdtBCdxAO6nSEIEEsI5g=;
        b=rleUnf38ywuldbbbR7v6vQeWl0OlnjbwoDYogeJxsYuZX1dMOmfEHhTAcwWIL3pByx
         0A6U/P9YdAKKYZPkVMx7lNAAxeMxDFQmpN74O4q/WpIBqbd+g9sl9HujtYTxHUYEUSu5
         YaQ6Yx7XbSyHF3Fs9iB1zcEjcC/+LqSAse3MBJVciy6c5RxSX+QSOS5SeFKYRPKNV16H
         EF18TbMQJjhuZJ8v+vOD9rWXXCUlHQn+rfJo9GhceiWeOKYnk8qXJS91kmcpIejveVUq
         MOfR/boS15kea5/yGQtgp85SqPj4y/QSWzFswZMbBZYkpaK+ZPzlMXrcE6HdLGILzb8M
         K64g==
X-Gm-Message-State: AOJu0YydwMcz/9IZlEwvbM6mRMluafdV+dz7exFRGek73YCkFB7MDnQn
	DnP77Jsf4I3W8xTHszsoHKBXiQ==
X-Google-Smtp-Source: AGHT+IHfX9pbgpUea7RKc2eNBDbLbmgIayqHTR8NILG28QoObP0K5P4Yh2KYlnBdB3iffpi/yNYDDQ==
X-Received: by 2002:a9d:6f03:0:b0:6d8:16a:e597 with SMTP id n3-20020a9d6f03000000b006d8016ae597mr4617948otq.23.1700852372505;
        Fri, 24 Nov 2023 10:59:32 -0800 (PST)
Received: from localhost ([2600:1700:19e0:a90:c242:2a26:eb7d:4205])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d6745000000b006d653b68fdesm588384otm.55.2023.11.24.10.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 12:59:31 -0600
Message-Id: <CX79UGJ80EBU.34DF47O8X8C7V@cloudflare.com>
To: "Stanley Chan" <schan@cloudflare.com>, <linux-pm@vger.kernel.org>
Cc: "kernel-team" <kernel-team@cloudflare.com>, "Thomas Renninger"
 <trenn@suse.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools cpupower bench: Override CFLAGS assignments
From: "Stanley Chan" <schan@cloudflare.com>
X-Mailer: aerc 0.16.0-81-g91b26ad93f93
References: <20231124185042.315148-1-schan@cloudflare.com>
In-Reply-To: <20231124185042.315148-1-schan@cloudflare.com>

Apologies, this is my first patch so I'm still learning.
Meant to add

Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

---
Stan

