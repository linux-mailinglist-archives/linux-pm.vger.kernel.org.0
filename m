Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B2346FC6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 04:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhCXDCi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 23:02:38 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:38629 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhCXDCN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 23:02:13 -0400
Received: by mail-lj1-f173.google.com with SMTP id s17so28326148ljc.5;
        Tue, 23 Mar 2021 20:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=L0ASU9cck84A4SR2JsZ6ZvDNL4r9jv1aWJ8Dv/WoYzw=;
        b=PSTNMV++VT4nJlNKVhZXUTc2qDeZDXj1atcrGjMbs6dZ4VKzizFF0a6HwbzOVV4hEl
         tVduja7OgTTUq25KYBFXpjTvM0x78g6mXwGguG2ppj5wqvAa6SMILBNqDe8d2BcE5cWU
         kPSGalpgMyPFTRje/BteYNb+eN/ixtxznyS2JJqP4C89ajrtq9vmKjOnTJ7m3pirExPZ
         jT7/ut1OgqM6yqpvbqoA4Hb1cPklYg8J2PQQosxh/u/8EAT6yGwf8o5xM95D78McmBEK
         gc4lCsaFasv1zBo45kYOXz07GpPPOJkv15OtyItpvsnls8BSJCb2cZ9d5TNCKqzDedKL
         +jYw==
X-Gm-Message-State: AOAM531RpJC4fokdzLa7LmUkjrj5sDGL4AQyfPI4KAFlQiyP/kwdKrVe
        XyBf3Rfg4YJ737rWx2pkH62ub/4N8NU=
X-Google-Smtp-Source: ABdhPJwJLXLm8L4PWQbaQnawfiLyDPBUQHSNwJSAxzwSo3+Z7cprqAUdYqst9h4ILxVGfPy6Oo1qzg==
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr601832ljp.450.1616554932233;
        Tue, 23 Mar 2021 20:02:12 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id i16sm121296ljj.74.2021.03.23.20.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 20:02:11 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u20so28285144lja.13;
        Tue, 23 Mar 2021 20:02:11 -0700 (PDT)
X-Received: by 2002:a2e:9b14:: with SMTP id u20mr582784lji.463.1616554931635;
 Tue, 23 Mar 2021 20:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com> <20210312154357.1561730-29-sebastian.reichel@collabora.com>
In-Reply-To: <20210312154357.1561730-29-sebastian.reichel@collabora.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 24 Mar 2021 11:02:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v67qO0acst+5QPDs_9WC0uYXwMUXYJE+1g=9WoM6_BnCfA@mail.gmail.com>
Message-ID: <CAGb2v67qO0acst+5QPDs_9WC0uYXwMUXYJE+1g=9WoM6_BnCfA@mail.gmail.com>
Subject: Re: [PATCH 28/38] dt-bindings: power: supply: axp20x: Convert to DT
 schema format
To:     sebastian.reichel@collabora.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 11:52 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Convert the binding to DT schema format.
>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Looks good to me. Though I'm not well versed in the new YAML binding format yet.

Acked-by: Chen-Yu Tsai <wens@csie.org>
