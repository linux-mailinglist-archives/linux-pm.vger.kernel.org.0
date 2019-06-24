Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625BA50504
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfFXJA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 05:00:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44409 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFXJA4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 05:00:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so12700351otl.11;
        Mon, 24 Jun 2019 02:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7jizqBodk35AO7xIq2o5Wq/JRXWrVWaNMQtKUKjKlY=;
        b=Aksw2oc5yKJmgo6Gn23nuOuNyUkAZgMcco4jzOXQlXUvatKUdDZZJvzU9OZgq9mHmC
         XsCoo67cGnIYbKmq4GuspQdgzTgGQ8pdCc01pMJ5PfE/FsN1ydy/+/fC8XU5OfR4DKrB
         ILuW/Mh89TAkRjsu55htj+qBrdVrfITKG98kZGsIIYaYp/MrL+Tl9Io6/7VZn1jVB6Fn
         O9BT0KRD9RDgii6A71zTWsd3cXxrEHXWY6OajBWtubh27yWjTl/kGk3cO+qsbObEsV2V
         0cSkzZHqMgKd3u5HSd5OvenBDP13apzTqWuzkdxIiwVIWTriIqMEoYSCOLHfAYFeFV2C
         u6HA==
X-Gm-Message-State: APjAAAUC+EwW5IKTS6DAPMegMtpoyJBoDToJonzoGDwUlD9LoVjh3nEJ
        /d1T8QU1vONgNfmzsF3k4f7zwRzW0/V8dOXiBrr6BA==
X-Google-Smtp-Source: APXvYqwZFrprMjOc/bF3rfscGOpj2DfeISakHXB5J1GJSpy0R3KafyBqp7yG2KxBQ+8KKJM/OnSXzLjK9/oIbK+FCek=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr23006277otp.189.1561366855737;
 Mon, 24 Jun 2019 02:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190621132302.30414-1-daniel.lezcano@linaro.org> <0ce0d1ca-154d-fca3-f739-573ecbd2b0db@linaro.org>
In-Reply-To: <0ce0d1ca-154d-fca3-f739-573ecbd2b0db@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Jun 2019 11:00:44 +0200
Message-ID: <CAJZ5v0gR1O=21FRXrDvCi_wingO5W74w9PX8s5s2=1aesYo4yg@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpufreq: Use existing stub functions instead of
 IS_ENABLED macro
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 24, 2019 at 10:53 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Viresh,
>
> On 21/06/2019 15:22, Daniel Lezcano wrote:
> > The functions stub already exist for the condition the IS_ENABLED
> > is trying to avoid.
> >
> > Remove the IS_ENABLED macros as they are pointless.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> what about this one?

Care to respond to my question regarding this one in the first place, please?
