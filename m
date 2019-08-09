Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633948847A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHIVR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 17:17:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43301 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHIVR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 17:17:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so68742886ljk.10
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4vLpkUXGaCx5ksGKXq1B6fru5dxWZeG1Id+VcyLndE=;
        b=G54KRPbppyCf6lOgHptflnWoJgyVEK93H+cXO/vp8LfwGrelRzgN5+IYoCLqXUrfYO
         X/Z645f3sLIDye0s3bOMNqrnMltaBkTAyYjneZ6d8DcT9/YcwkbfnK/Nth/KaLZbh+2/
         SYW0DZALxCSJQavegwiXuKNfFYGJX1d3/zt9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4vLpkUXGaCx5ksGKXq1B6fru5dxWZeG1Id+VcyLndE=;
        b=I9myp64R/7V6CvoFzrYXe8M0BfLPXjwMcAS52YnzK4Op4ck2OfM5Xsl7KXsQG63qS+
         DLnFmX55lUZBUr5ieJTCGmp2WcbjRfjxO3PrxdjQvI7gQgPJhjN3IAbAit866h8JiQD/
         EwLriCcJncnvVG4RlezwQ402JAWEB7ozgcum31or8jP++6O3laOm16MXsYvrRe8z9Ac9
         w1rdt2GQwHSSH1JXUksHE4SB8trAOwZYRlz0PN/e418qyBa1rmt0E+tTtSJpgQKHSBuy
         cHCcE54lP+6RujqLpj2XfWAeFHqGJ/u5bInTjn4BpH5m97cqnqOZgHssD6c0zDEI9PG9
         ftsg==
X-Gm-Message-State: APjAAAVxM6ygd4XtdcK6r1FcrY/1egJy30d/PTCT1yNYEGlQbhuS5xgj
        pMGp79J+Zc1b4kvsskCd/trLogXKvsI=
X-Google-Smtp-Source: APXvYqyE7+y+jS7C1+w54bTnBGvbKVVxCfFNyMfT036IIdwd8TjgWTmwo6ur7hUlCFXEnbxGSIaLoQ==
X-Received: by 2002:a2e:9989:: with SMTP id w9mr3053984lji.133.1565385476039;
        Fri, 09 Aug 2019 14:17:56 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h10sm17739313lfp.33.2019.08.09.14.17.55
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:17:55 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id i21so14043468ljj.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 14:17:55 -0700 (PDT)
X-Received: by 2002:a2e:93c8:: with SMTP id p8mr12301485ljh.6.1565385474677;
 Fri, 09 Aug 2019 14:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190809121325.8138-1-georgi.djakov@linaro.org> <20190809121325.8138-3-georgi.djakov@linaro.org>
In-Reply-To: <20190809121325.8138-3-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 9 Aug 2019 14:17:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft5JD9QuH3cZpPX=4eJMjbyPi8nes1--6qcsKdb1sw_rNw@mail.gmail.com>
Message-ID: <CAE=gft5JD9QuH3cZpPX=4eJMjbyPi8nes1--6qcsKdb1sw_rNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] interconnect: Add pre_aggregate() callback
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

On Fri, Aug 9, 2019 at 5:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Introduce an optional callback in interconnect provider drivers. It can be
> used for implementing actions, that need to be executed before the actual
> aggregation of the bandwidth requests has started.
>
> The benefit of this for now is that it will significantly simplify the code
> in provider drivers.
>
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
