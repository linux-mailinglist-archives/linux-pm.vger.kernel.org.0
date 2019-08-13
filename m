Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF23C8BF5F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfHMRJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 13:09:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41283 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMRJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 13:09:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so102220161ljg.8
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVzAnVzEMjxkSBqu8V9mlBdGqDjrrYQzVhEjxzd+3hI=;
        b=I4qWR+mzqRT7c1SEkHGhKmL6s1EYBMsgtyPriDKNziH+B4FMxlEGuvrJH5HcS4lcUd
         oEuShorJ4j1kTmfzSPRIGn/stYQAr97GOiXpjAyAAXj4cxkN8Dy0uFFDrdXb/ecYQt9m
         1yniZalDerzD5yTNTTGHitP5LFfOrIUdgwpGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVzAnVzEMjxkSBqu8V9mlBdGqDjrrYQzVhEjxzd+3hI=;
        b=Ihygdww829GbPCZF0t2bB1nehay3dQnKIM5yN6kF21uv3yjM7/xt3xIPCaZPtipFHs
         QoOE0EiaEvO26kfDuxjk1RZpUvwHRXreqZHb2loo/EMGtujejL9+epYOoHRUsjrqPXTd
         P5DGvMwfwjL/9jCivhf4WernIukOFVQqozR5K6n/QfTltTXqWG1RxyWzo9bE2mtWKGDO
         s670eKUbRZKv9LKNpO0FBSrLPZ0PJAPgz8WD50WdanZyr4tfsTlA0vZOMQfY3ZSc2dYL
         uIOEANb1e+CTfdh5aoLJYI5jgjvp9H9VtvIgfoaLup4+BAO9Ll7p9C5QTZW3rr3y6eix
         DXmQ==
X-Gm-Message-State: APjAAAWixRXFEJx2ZooH6bpD64I+XDxM5BY6invu+JlsfqxNYO6HvaqT
        xb717tFmmM1iS+ZavgqtIUA1/dghGFQ=
X-Google-Smtp-Source: APXvYqzfMkxOkKxQh0suC8Mrhvy3ZGDv8zJXwYH3kb85T0Kdw/zi3vPVsKvKTYN6JmfREuQ8yLR3iw==
X-Received: by 2002:a2e:8545:: with SMTP id u5mr8529449ljj.125.1565716158606;
        Tue, 13 Aug 2019 10:09:18 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d7sm19686641lfa.86.2019.08.13.10.09.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 10:09:17 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id h28so77213956lfj.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 10:09:17 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr22803433lfb.29.1565716156648;
 Tue, 13 Aug 2019 10:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190813145341.28530-1-georgi.djakov@linaro.org> <20190813145341.28530-4-georgi.djakov@linaro.org>
In-Reply-To: <20190813145341.28530-4-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 13 Aug 2019 10:08:40 -0700
X-Gmail-Original-Message-ID: <CAE=gft6ZpM6x21X+SxCbNDdNS5B51yYAFA0XBbViqLmr99n5SQ@mail.gmail.com>
Message-ID: <CAE=gft6ZpM6x21X+SxCbNDdNS5B51yYAFA0XBbViqLmr99n5SQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] interconnect: qcom: Add tagging and wake/sleep
 support for sdm845
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, David Dai <daidavid1@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 13, 2019 at 7:53 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add support for wake and sleep commands by using a tag to indicate
> whether or not the aggregate and set requests fall into execution
> state specific bucket.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
