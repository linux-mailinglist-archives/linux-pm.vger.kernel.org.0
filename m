Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8C6EA9B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 20:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfGSSWy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 14:22:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39613 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfGSSWv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 14:22:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so14811348pgi.6
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=Re7bGdDSOibN8TyYx8ctmhIgW7ORnAd3d48dCZJCs8Q=;
        b=oEoDF/B5t2C4jMyi0S3gpDDDEAULRf8xC6rFSgoeZdTzvCnFkmp2+heSBg+MUNkDIK
         79pg5Yxh7fPZnpa/k7fQwwMAqUxRN8E9EliidC4XXf5Ub3aqt9uKBijJG11AFMkmnDa8
         VEjbN6CNTvnTRyBw2vzdxu6dkh15XZOgB/88Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=Re7bGdDSOibN8TyYx8ctmhIgW7ORnAd3d48dCZJCs8Q=;
        b=EAUMYEiMv6vOSErGVqhdF2wPmBQKoS6M9YKZzzq+Y8PY2cjwLgvavIxrFWGXczmby+
         q7WkHcIIVoKb+Z5YF6GghhSg5sO9SDAmiREQ9RvNrtZHuxhrGFmFLkBIoXUPKiTATKea
         yO03PZs4xNk2bkrv3/DrwnziKEbRz8pYMk/MIv/9H+5/WLdXd4GKxPIbuprf26g1bLN8
         /xmfCMsZ8RW68YI/Wsy0P0GAcGS/XOIo/vS5qp0st/jHfsxYFX9k0BOmRUIhvY4zAadG
         dR70pSmhJlchY+PYLj8KS5CSuil/iFCeqWJkqRlO6dqWV7Vzuwr98MYp6CWAW5FmcCvK
         YkYQ==
X-Gm-Message-State: APjAAAUc5UzKAQw4SAIq9wyy2ilMLnEN/Ur0qgF2o0YodiLA69zgy13m
        Mb9twBC8GDhAh2dUVkOOhQ9mzw==
X-Google-Smtp-Source: APXvYqxLDMfkGd7dZydioh7pVtp9VngkVUtndNJ46UNpuFKD1wUMhzFnwP3J+Hp0NedhZzJZxsIESg==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr59661059pjn.134.1563560570145;
        Fri, 19 Jul 2019 11:22:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 81sm52293060pfx.111.2019.07.19.11.22.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 11:22:49 -0700 (PDT)
Message-ID: <5d320a79.1c69fb81.17c57.b9ba@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190701152907.16407-2-ilina@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org> <20190701152907.16407-2-ilina@codeaurora.org>
Subject: Re: [PATCH 2/2] drivers: qcom: rpmh-rsc: fix read back of trigger register
To:     Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 19 Jul 2019 11:22:48 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Lina Iyer (2019-07-01 08:29:07)
> When triggering a TCS to send its contents, reading back the trigger
> value may return an incorrect value. That is because, writing the
> trigger may raise an interrupt which could be handled immediately and
> the trigger value could be reset in the interrupt handler. By doing a
> read back we may end up spinning waiting for the value we wrote.

Doesn't this need to be squashed into the patch that gets rid of the
irqs disabled state of this code? It sounds an awful lot like this
problem only happens now because the previous patch removed the
irqsave/irqrestore code around this function.


