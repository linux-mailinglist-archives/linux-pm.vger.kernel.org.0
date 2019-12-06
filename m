Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3AC115844
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 21:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLFUpY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 15:45:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33617 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfLFUpY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 15:45:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so6294907lfl.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 12:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMYyDKhp6K7/5SuIEY9a+3PPHyckatVY1BJEQOFbYPw=;
        b=kLQzpX2iLT3Cw3LYn9w2xUhbQcZ1mnSOxrIeil8QWxuKB6jMDdBwqMcFQCjopElDvB
         9xVPY7OFh1i2ZL3ZJ1/IwfRSv+r6pliXLzcDbGK1wuAftk4uOBp0N6z4sVbWHKY7TjUM
         FDR3SKEII8ZT9AUEOqqRtcygJcuT9RKG0JZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMYyDKhp6K7/5SuIEY9a+3PPHyckatVY1BJEQOFbYPw=;
        b=dGs9SbZrRp7CpmRgknx7Y6UgAU+frJIr/hvvbvVoMeYgNwVceqwExftt+tDkPABV6z
         WtfF5gfPf1/Htw+6aEXiQKZsNajp0Z/9bPCfcHag4cAd/DPUNg6Ncq7OPbkiJfa68kV9
         6s1QgJse3npVrsn5tliUL3OKD8bLM1YS3gTDNKy1fHz22CdFfqZhxjy3hRtlUH4UtUMB
         OWQBe/t1EHNo2f/nPaNwFa9IljQsA6pjpCHupxJF1vlfYa1n2mQNMSn6W5HhGMGFbHaz
         kf3e05f4LGBinxUKpOB93IcJ3OEXTOHoaXD2RM6axm8dPxsAaxGe4kOAAlpRoxCEeDiZ
         0tZQ==
X-Gm-Message-State: APjAAAVDDffNXLebaU1rrOAVFQ7fD0DrA/ak5j6IbbNa7lHolDQhp5EX
        7u3wAenC/hS+ecn5YVLskpUoasgXTOM=
X-Google-Smtp-Source: APXvYqwgbTkLU4RTgPVVHbR3I1NEKl5FYQK6YwLr78pD8ecRdH+tEpt0/2XBzrkhZbi1TSs2PA1Q/Q==
X-Received: by 2002:ac2:5c4a:: with SMTP id s10mr9124032lfp.88.1575665122229;
        Fri, 06 Dec 2019 12:45:22 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n14sm296051lfe.5.2019.12.06.12.45.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 12:45:21 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id f15so5423904lfl.13
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 12:45:21 -0800 (PST)
X-Received: by 2002:a19:ec14:: with SMTP id b20mr5175962lfa.63.1575665120607;
 Fri, 06 Dec 2019 12:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20191128134839.27606-1-georgi.djakov@linaro.org> <20191128134839.27606-2-georgi.djakov@linaro.org>
In-Reply-To: <20191128134839.27606-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 6 Dec 2019 12:44:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft7WHWohbRLk-ungR54p_LUQz5TLeWsT1PtMVRza9M5H7w@mail.gmail.com>
Message-ID: <CAE=gft7WHWohbRLk-ungR54p_LUQz5TLeWsT1PtMVRza9M5H7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Use the standard aggregate function
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Dai <daidavid1@codeaurora.org>, masneyb@onstation.org,
        Sibi Sankar <sibis@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 5:48 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Now we have a common function for standard aggregation, so let's use it,
> instead of duplicating the code.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
