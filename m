Return-Path: <linux-pm+bounces-750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B672807073
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE49DB20D84
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50037140;
	Wed,  6 Dec 2023 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8UPfId0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2571D3;
	Wed,  6 Dec 2023 05:00:05 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2886d445d8dso123205a91.1;
        Wed, 06 Dec 2023 05:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701867605; x=1702472405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXkoyIjsj3VFQLqSCiUmrQOBMRg9H6OEJrpjPXTxE+4=;
        b=m8UPfId0Kly6RpGyi87A4VDHk86YWD19RFtKhTTL7gw8Hk6tQ/x7UkiDn5rpCdHBLO
         uyjle4YE16+T06rXQX+SowOysw07EE1LzpWX+42GTGC2Q+L48wkucfaEbsqIferp+s2T
         jOifMVMdH/LxD1FtbBS5NAQR+uoW0HKJi3DYjUCKeKp7hs+vC5jHBUjtTQjXBvgv22s0
         LxbVJ61AVF5FN1AuQFQlxFengW3y/eNAndgOfNcd7BHTh8xEa6PIi8IPFSvm/oqPY/Hu
         ffFWddZ5NmoN1Fpc/NKFFf5FDmlo5jRInugwynHvcF/PRZBAYSmPp5GJATWlORaDEvsE
         MuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701867605; x=1702472405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXkoyIjsj3VFQLqSCiUmrQOBMRg9H6OEJrpjPXTxE+4=;
        b=XdFMBr8yTF/aTuNwcfR6EgdCRXZBSq5Siu8TjVFpNImKw0yEX/WnMMXdUMBqfXhlwg
         SWLY5LOw5WUR9ULD/KQiHZoewbNNooAJx4d+D+Bi7ixdfJw99A87MQ4OpZqqBq5bevxB
         5PhL42JFsBoOreDGjs52/CWPYoNSXuB+5x+v5+7zt3NQktQBuI6kdo0ux7qdu0rcqP/W
         01hrwamUXnXGmm1Fhp0KmNfxh9BRk2beaFXQn5JJsBKBsPfZ0cSC9JnzNSKp5SAIEL7h
         nhcKzB3XFa0x+YN9Gwqqg3RlVlvOUSOCk9G3dFmYJ+5N411Y+dHYauB3VdwheYKchI9K
         J7RQ==
X-Gm-Message-State: AOJu0Yyad5IzupsAu6BNwSWq8s22PkLWgjOmde+vZHqPn+25laQqryuM
	Bn20+5j0okkExOvRa3qqbug4oSmArrtsFOgk3fo=
X-Google-Smtp-Source: AGHT+IEJdrZqUvh7lgO2J9DGb10XOrt4EgAX5W2bSFyBr7IADzldLbR4PZO8qDrGy6EgkZ038ZXMCuJx+2zbGGLghng=
X-Received: by 2002:a05:6a21:188:b0:18f:c8e7:ac9f with SMTP id
 le8-20020a056a21018800b0018fc8e7ac9fmr1657404pzb.3.1701867605308; Wed, 06 Dec
 2023 05:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129124330.519423-1-festevam@gmail.com> <e0b9c0c1-eae5-4664-bddb-56515e9fee56@linaro.org>
In-Reply-To: <e0b9c0c1-eae5-4664-bddb-56515e9fee56@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 6 Dec 2023 09:59:53 -0300
Message-ID: <CAOMZO5CTBkT+T+wevFRYyBJuwMCiUoFuDKGSyYNNZQ9CWsEJrQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] dt-bindings: thermal-zones: Document critical-action
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, mazziesaccount@gmail.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Wed, Nov 29, 2023 at 10:13=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Rafael, ok for you if I pick this series ?

Please let us know if Daniel could pick this series.

Thanks

