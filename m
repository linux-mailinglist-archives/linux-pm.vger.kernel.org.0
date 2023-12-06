Return-Path: <linux-pm+bounces-753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E8807175
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 14:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BD91F2157E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDA3C482;
	Wed,  6 Dec 2023 13:59:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7B0D49;
	Wed,  6 Dec 2023 05:59:03 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59064bca27dso49055eaf.0;
        Wed, 06 Dec 2023 05:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701871143; x=1702475943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM7PW68SSGW5GEwKqYtJSH6yKZ3e5u5JTl0dlQnMyAA=;
        b=QvmiLiud6nxKMCtEDxKobaPmZGsby9nLqiG9B45ubBhnY6Ky8z/CCn9s373C9PkdNF
         oZ9xpE2hNTDF/fMZxbG3ML5i8A00vTIRggEfR6KPM6cLCHVf7mf6C7QIxjnr4EcYmnce
         8XfNtwWc5EVKkou3sy9VO+rNfmVWTfrW8hPw+W+QZROnzTjPqwuMiJmssZiPZhNNlJ7V
         XNNssB4vvwNke3v/ibmrdLl277Bp9tidugdbD1ATxfeetm0Jb1qwxdTg4rKol3gxLIFq
         brj2qUO+64sW/T7Kw/jA6z/TbdZOHLBuaYF3Xf0OYaIHouHZWkp8KHCAT4vTxiwqIzEg
         KPfw==
X-Gm-Message-State: AOJu0YzcE1UihGqPehgKM7yQIs9mIYKRAK7HgXlqdTvPoaYent1fA62O
	7eGMmFN2ZEFkMgNIuM1Aag==
X-Google-Smtp-Source: AGHT+IGwzXIjKjGQAldv4Ft+XEBaqO+EE8tAbM2Un/3+TU129n31AOHBS/OkKjO+T8RUUYF+Td9F9g==
X-Received: by 2002:a4a:e6c9:0:b0:58e:1c48:39ad with SMTP id v9-20020a4ae6c9000000b0058e1c4839admr938705oot.19.1701871130695;
        Wed, 06 Dec 2023 05:58:50 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h10-20020a4aa9ca000000b00586c4324f5dsm2629048oon.35.2023.12.06.05.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:58:50 -0800 (PST)
Received: (nullmailer pid 2053172 invoked by uid 1000);
	Wed, 06 Dec 2023 13:58:49 -0000
Date: Wed, 6 Dec 2023 07:58:49 -0600
From: Rob Herring <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Steve Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
Message-ID: <20231206135849.GA2051159-robh@kernel.org>
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>

On Mon, Dec 04, 2023 at 05:25:02PM +0000, Biju Das wrote:
> Convert the below bindings to json-schema
> 1) DA906{1,2} mfd bindings
> 2) DA906{1,2,3} onkey bindings
> 3) DA906{1,2,3} thermal bindings
> 
> Also add fallback for DA9061 watchdog device and document
> DA9063 watchdog device.
> 
> v3->v3.1:

No, it's v4. The various tools (PW, b4) don't understand point versions.

Rob

