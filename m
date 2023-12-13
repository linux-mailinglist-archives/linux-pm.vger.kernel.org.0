Return-Path: <linux-pm+bounces-1058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B981104E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 12:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B28628150D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7A624212;
	Wed, 13 Dec 2023 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em6RKa4A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF0B0;
	Wed, 13 Dec 2023 03:39:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so1085707a12.0;
        Wed, 13 Dec 2023 03:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702467579; x=1703072379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alNPeiad4BuLGwYFjx6kIyBiG7mdOHQ/bq1v+yhyPSA=;
        b=em6RKa4APQGbbc+VYcQlhadCs+KnHDsiMmGSPxSR2lkPnfhY+jw2Goqta9cTDCVlDA
         5NSTl7A2/1u8c3JF6EmQRWsrU/UyOCq1OpChRRZdzU1V5IM98u9CqRSW+vZ5wM7c6UEJ
         0Gv72yrwXczcGxgPuN3ldhjFonlEk4rcE4ojHmzmJtSvLAsgXDS4Ynb9IVlo3J4DSY2t
         /r/oSH1NaWBALv7wWS2b23L9tKZWA/W0aoD0EQ2+j5W10nbv8NM44pgorfFy/MPA1jot
         bFNpSBSxsXngF8RS+dgIY0MNh2I6YljGi8dyPnIhu0zm9A8Q6NjP1xicfLxxf291JUUR
         ax0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467579; x=1703072379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alNPeiad4BuLGwYFjx6kIyBiG7mdOHQ/bq1v+yhyPSA=;
        b=EF+ABzp6Iec5U91RSx3tHNJuhYeuMkxsdsbkATXFji5swRsnM6M8pJqh26C02zC6is
         txNe16C4ikhrd7oENnfCCsa7dk0C8FsLBG9yk7JXcd2G6pMV+/xSSq8C8b22ZNzkAh+L
         agu7thvmycTi+RBhidEq58XnMR2JeYOUs4TtE9mIqTQTj9m2iyu7RtxrvPQTFyZvpBxC
         BTNrhBHr1bE1JCCIYhvMuu9t/oj0XQSvs6K+IhFsSxgS3RcwBgtaM+zMScIe083IE5KZ
         hfJJaN5KyQV/JE/lw36aKrhk3I0zb777iLHYKM3zOMUGD9EYdfKhzA9G4Zfgw6z/o46G
         xCMg==
X-Gm-Message-State: AOJu0Yz1/G6ta8xea4UbwGitL2//bGTpvF0xLcAVD130fH6HXXFkjx6y
	qcFrjpN1iYStV69/87OvWMcimbrJ04ZQnFuPKoAFXw9l
X-Google-Smtp-Source: AGHT+IH17UC80f37r0NrHK3zD/k6V0R1hl39Dt2UcSCeCPsh5PX9idprVzXpuwP7c6N942RpzhN2fPeJ6WqtZNX7PQU=
X-Received: by 2002:a05:6a21:78a3:b0:18b:a1d7:a736 with SMTP id
 bf35-20020a056a2178a300b0018ba1d7a736mr17570455pzc.6.1702467579444; Wed, 13
 Dec 2023 03:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129124330.519423-1-festevam@gmail.com> <e0b9c0c1-eae5-4664-bddb-56515e9fee56@linaro.org>
 <CAOMZO5CTBkT+T+wevFRYyBJuwMCiUoFuDKGSyYNNZQ9CWsEJrQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CTBkT+T+wevFRYyBJuwMCiUoFuDKGSyYNNZQ9CWsEJrQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 08:39:26 -0300
Message-ID: <CAOMZO5AhP1Jhjte2dncWbmWzJ0ZHK9PrOC=pQt8YANTU+B076Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] dt-bindings: thermal-zones: Document critical-action
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, mazziesaccount@gmail.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael, Daniel,

On Wed, Dec 6, 2023 at 9:59=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Rafael,
>
> On Wed, Nov 29, 2023 at 10:13=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>
> > Rafael, ok for you if I pick this series ?
>
> Please let us know if Daniel could pick this series.

Can this be applied for 6.8, please?

