Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F22161F9
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 12:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfEGK3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 06:29:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42604 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfEGK3q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 06:29:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id d4so346291qkc.9
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2019 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3A7k4qEvSKxMLHdGDRgdP5qu7WvzNwyk4XvgJKmxOyY=;
        b=YljmO1hQAmfgxVa2ZUDLvw+LWUoenamWGX9FvKc0/CQi/mda9c5hckx5IqKGMfyIhA
         68Y6Z/EvYOrO3PMVQOhS5LXIf3q8fOhSWPKatCt1jBLF58PQI+qUnk5arfSWDKKp15yr
         ICKPLDh8Z+0LduEL2m9TwR/Q6brnUC0x+OTTN0cZulJwoehI2TVGPnZDh8Ql6urlKCvW
         v9eVhoOFdC2skGYESQYpuFZyd81f2gnxS5/tXc77ztmQ47bF+rlkPNP20sAr6tXxCPiL
         rJeA5onePXsvQ7cDmUxJ2FM+S7p2ksMgnRmLaSRidCsnGxCBkqBZYUyMItk5uDDmBHb5
         MbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3A7k4qEvSKxMLHdGDRgdP5qu7WvzNwyk4XvgJKmxOyY=;
        b=HJOw4xRzxlG9uFngs3TkKqBugvbwgROFq0MYfAl/qszHVEll6qTPVoK1SCxDPMV7my
         8rNF6cQ5hXKr9SECyIAStAGdSIJCpjWnUBhByNAgK3/Xlph5Y5wiCYSCju0H8QFNc377
         Mf4pRfMZuZ2QXd7msYxPWU5TA5ZHA0U8G39nQCav+nbBmoAH4E0xjVHUR6E6Cdn7SWhW
         8YHM+gAccIgOChxpYPiKZ/Im+ccFI0HgDiNhH8Kkgm3olO6dBIw8/M+u4MngvJ1EA9Uy
         cXE78iVgZevcYqUVygRxhxMBhyvjOjGivJifP2xllJ47Pi1JcpoL9k/cchY1aGmsduCJ
         RD4A==
X-Gm-Message-State: APjAAAUITmbaFOS2MCrPkt5VyY67g7jOzPseX4dIZ3Dv9gwUuFnzhGOs
        ldBEwD8L+3sxo040rG83GjG74WUrTEJSf1Mz5t6Ctg==
X-Google-Smtp-Source: APXvYqyXgcpt8A0cccehzPV4og78sWjY13s34rY5v1SbtEaR/NJl59h6j0jhqilhYO9sG7mL9ZF9J8JwBZuqEe/y/98=
X-Received: by 2002:a37:508a:: with SMTP id e132mr23910887qkb.281.1557224985254;
 Tue, 07 May 2019 03:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <DB7PR08MB3801953BFC1A48BC8F9F83679C310@DB7PR08MB3801.eurprd08.prod.outlook.com>
In-Reply-To: <DB7PR08MB3801953BFC1A48BC8F9F83679C310@DB7PR08MB3801.eurprd08.prod.outlook.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 7 May 2019 15:59:34 +0530
Message-ID: <CAP245DXfm-1U34UOsFio7ZQwoiEaecW9cC4ghmXrzTJPVbs0dA@mail.gmail.com>
Subject: Re: linux-5.1/drivers/thermal/qcom/tsens-v2.c:54]: bad assignment ?
To:     David Binderman <dcb314@hotmail.com>
Cc:     "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 7, 2019 at 3:40 PM David Binderman <dcb314@hotmail.com> wrote:
>
> Hello there,
>
>
> linux-5.1/drivers/thermal/qcom/tsens-v2.c:54]: (style) Assignment 'last_temp=last_temp2' is redundant with condition 'last_temp==last_temp2'.
>
> Source code is
>
>
>         if (last_temp == last_temp2)
>                 last_temp = last_temp2;
>
> Suggest code rework.
>
> Regards
>
> David Binderman

Hi David,

Thanks for the report. That was an old version of the function from
downstream. I've now refactored it and resubmitted it here:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1922871.html

Regards,
Amit
