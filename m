Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C850CA3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfFXNxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 09:53:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41480 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXNxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 09:53:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so9764904qkk.8
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zzXjt7UfyKZ+6a+GApdpMxHIx8cZsvS2RxEV8BXMfQ=;
        b=noh7jIDRMwMyxyipvaIytC8YQmbwP0uT1vSOrXmDcgwNiw6XLQxb3A0nURGa8XdC8Y
         xc9xwROEm5cj9fOXhl3u39WKtF+K+PwndvaErOUn7a2zEXFN2OD/BDxoJNR0xrHpUqpA
         PzAx8IoISGTeG3YIvfvJuC1Kke/dyIoh8GRd6pC5X8iBhuUUGWJ6kqoKbN76UFpYwWy4
         AGsPp7mi1leQYPrw5fJQxPW8HfZ7dH9BXOdl+A/YDyPO6qTVyvVlQpla5xGxLCskxesK
         dnNBeKEhZEwxR7e7dYKo08uCdTHn/7uFqHm/5qGuLy6IP2Cje72RfOuhfIA+7IMbhPKb
         ZuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zzXjt7UfyKZ+6a+GApdpMxHIx8cZsvS2RxEV8BXMfQ=;
        b=m7YcOIjaIr+KrcUpVek8KwknvkDejL72rOJvXFvk/RepLN2wAsaVI/7a0IKovJneAV
         6Bk/wbJz5rB+OndYm2y/0RIUFAwG/adLg4enjzPSZEKJGvxQoZUT6X9X3D7uGoM/LCVs
         ix0e15fEMxjsAjE1OTAmzjaNXxxK7vug23HSxPDUpPRbxzrMB+A74+r3FfckG+H0Fmeu
         bd08F5qdnJd3DPzUWJej6d+2JO1mcmH/Wxz7n9RfdT1KnxitV11wqld7ftpOaz1VRXAf
         tX+EDUOQS7eX5m15gXiZ1iBxusf14f08g2zdv2Yg9Eh5VsI2MGj/CK2B4ZjwJH4IFka5
         Efyg==
X-Gm-Message-State: APjAAAXhU88/wyfmUuA8UmBavakDZQYc5WR9loTww2PE2fpzd0ou5DFe
        ktXW4zDExzbRXpjlM6WCwLMKa7A4bxnKCYzytK3vsUB2VkbhwQ==
X-Google-Smtp-Source: APXvYqyxDv407xTUlO5duI43y0iYwskT7UKhOzIWLu5uIcWfrc875G5NOk6ZNPHSQuk85sRD50nIHR6L1rREhCABsDA=
X-Received: by 2002:a37:4e8f:: with SMTP id c137mr338486qkb.127.1561384387727;
 Mon, 24 Jun 2019 06:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <f1efad22-66a6-a094-1ebe-43e794aff6d0@linaro.org>
In-Reply-To: <f1efad22-66a6-a094-1ebe-43e794aff6d0@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 24 Jun 2019 19:22:56 +0530
Message-ID: <CAP245DVGekWAS1O6ZbNi52K5LyQw8vqVXM6DSBvOieAT3v1fpQ@mail.gmail.com>
Subject: Thermal microconference proposal @ LPC
To:     Linux PM list <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

We've proposed a thermal microconf at LPC again this year. I've bcc'ed
a few people who were interested last year. We already have the
following topics listed for the proposal but could certainly use more
topics especially from the non-mobile Linux community.

- Samsung: Thermal aware scheduling (Lukasz Luba)
- Linaro: Combining idle and freq change for cpu cooling (Daniel Lezcano)
- ARM: Discriminating thermal throttling (Volker Eckert)
- IBM: Sustain turbo mode (Parth Shah)
- QCOM/Linaro: Make thermal framework easier to use in products (Amit Kucheria)

Please help bring this to the attention of those who might be
interested in talking about thermal-related problems at the
conference.

Thanks.

Regards,
Amit Kucheria & Daniel Lezcano
