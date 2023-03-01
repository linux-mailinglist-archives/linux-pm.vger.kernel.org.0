Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42A6A73DB
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 19:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCASv0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 13:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCASvV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 13:51:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8B4DBE6
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 10:50:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so57981346edb.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 10:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677696654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iUZAnJK6gz4oERofIoMWErNXIlGl6/+yG6iePuXC0I=;
        b=SH1hvF4cekmNNuLzGJNvbwmiRqMWefpWrvuBH5nUXugL0/YnCeGYDKofhhOfm/NBZp
         EKfk8PnZ2Bog+HJhKARanxH3WC7bcxgur/lebKPQg22cY2lxwdGk6pD58kZGaA0C1qnn
         vfNMNmkIhWirfSCyHpyNZv13XyryDgYV3E6b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iUZAnJK6gz4oERofIoMWErNXIlGl6/+yG6iePuXC0I=;
        b=4UJbevEHuWABS1wgHKJdopdSrLhG0K2DahqnVUQudca8U0sG+Z/SwtLL6IrTnJlYNr
         QTFVIxRwa1R2NbujpjqsKe6fft8BnBDtK/Dk4veyq3IaWTflqxiiuzaU7V3kWOdgZSQs
         ilRf2LfLJWE0fhWG+poRehtfVxz4XzFwmoZpo0TS9uq3g/NPm2KOC3842CAarS1e3std
         170+3DK71HiMGoYM6dIW5kzJI+PNaSEDws0egirqoQ36K9yML/4hWsW/UeZNmyBRfhAz
         ZAc5019BjeccG4vnZDMpeMBBQb/ofCUmVZ0OSwiPlEFJhaJKviGqbsgLNCOzxcmYHsv3
         Dq+A==
X-Gm-Message-State: AO0yUKUVpMsMCxdQzfUqeI0gbBIYal12a4xCVxZNQXSUnSgSFWmfMWUQ
        LX2yaDO56F3kmbvfm3uffD/dTnFSmrRph5cgLMm6WQ==
X-Google-Smtp-Source: AK7set/xw4LP1FGGzF/+igfTDKFWIww6jGhunDikpuYZaQbPCBeb40XpRsT0GUOf0kAZYRskGwMhYA==
X-Received: by 2002:a17:907:720b:b0:878:4497:380e with SMTP id dr11-20020a170907720b00b008784497380emr9808445ejc.4.1677696653803;
        Wed, 01 Mar 2023 10:50:53 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id gw26-20020a170906f15a00b008e204a57e70sm6098972ejb.214.2023.03.01.10.50.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:50:53 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id da10so57980969edb.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 10:50:52 -0800 (PST)
X-Received: by 2002:a17:906:c08c:b0:8f1:4cc5:f14c with SMTP id
 f12-20020a170906c08c00b008f14cc5f14cmr3831646ejz.0.1677696652007; Wed, 01 Mar
 2023 10:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20230214132052.1556699-1-arnd@kernel.org> <Y/+WghSbz3l6uipn@dev-arch.thelio-3990X>
In-Reply-To: <Y/+WghSbz3l6uipn@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2023 10:50:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+O8OqVD36P+1cbe-B3wbB9BwfwtM1E6evObs9VpYz3A@mail.gmail.com>
Message-ID: <CAHk-=wj+O8OqVD36P+1cbe-B3wbB9BwfwtM1E6evObs9VpYz3A@mail.gmail.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: remove bogus do_div()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 1, 2023 at 10:16=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Would you be able to take this patch directly? It seems obviously
> correctTM, has an ack from Sebastian [1], and without it, 32-bit
> allmodconfig builds are broken [2] (the other warning in that log has a
> fix on the way to you soon).

Ok, I've taken it directly.

However, the whole "seems obviously correct" is true in the sense that
it now doesn't complain (and doesn't overwrite an "int" with a 64-bit
value.

The actual code still looks odd. Is that return value for
BATT_CAPACITY truly in that odd "hundredths of percent" format, where
dividing it by 100 gives you whole percent?

Because "hundredths of percent" strikes me as a very odd interface.
Even for some firmware interface. I realize that anything is possible
with strange firmware, but still...

             Linus
