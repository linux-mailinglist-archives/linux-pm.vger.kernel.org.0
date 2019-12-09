Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D020D1174DC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 19:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLISto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 13:49:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40775 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfLIStn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 13:49:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so401457wmi.5;
        Mon, 09 Dec 2019 10:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieJvOVklxuG7HYJXPgw7cQzJLJhBqz5GQLQqmQnTPp4=;
        b=Lwf95EfzH7X2wqXwpLouZbCqEIcPDGv1zMT1wNBySqePdfmNyCiRNxM/Bw5YYaCGzR
         8vaqCCts8pf7TdrQXmK3MXHS5wSBZ4WMCDjBmo8nDUHOUqNKLb73ez8jEar32qCMGuSv
         N1zZz8s5JTzYlWwxjBNBR2bpCa5WuOGrH/1PkqGEK7CXMso4w0yakRIo6W1WH+KfGXxT
         YhOqn3ywUJW+3cCDUlxh3w4ekLu4JOhauTIDHt+l0KEzbnrFWhpF44GB+frbLehyZaFy
         YRkFO2fPSmlhc3o6qx8+gDkyYqnq7NdwRcs0P3WtfURDvDAEQfRncYb/MI1Wn64ctylR
         DUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieJvOVklxuG7HYJXPgw7cQzJLJhBqz5GQLQqmQnTPp4=;
        b=c/iIZw+/imPp3bgMAGirA/EmV0clTmLD5EGprtBTAYzrho9umrbunN0k9ZBaZNMtOC
         DgZCC5NBZUn34nr6/NAcRrKdwlQ+5iIcSwgj9VSQmlpjDGlajrPn27LGPhhNpvHivqR3
         0YLrSKNR5bZwdN/EO6zTXg/BVIRJzncLRSMdQ3A+Iu2eMM9OjYbwBVur2Q06dveYMvOo
         hSKl2kkfDD8UeNRzV4TdPXc4cq3JQrORK+cSh1dL7ocBqlQH/hahS7KyIcJQXzPQtZuB
         X0rijvMsrnDxfH183qZ/BW64z6yrLtWKSxHqacx1ihtSx0ZnMur/ZBEACzpOMvHWZfWT
         4w6g==
X-Gm-Message-State: APjAAAVRqDgX5FvOXvhRhUtvwk6cvk1noFzT/+53x6XHAPIfnnkcraan
        JLfnxk3QB7QrAIHstg7rGlnK9aO6aCsFOEkWrhM=
X-Google-Smtp-Source: APXvYqyINvbXlKGlHkBtb2/gbmqbckNx0an6BfCyVuvVe7hes9oGx6nniEIkTZxW7OEwUEirs3vHnefdx1qjNHf1ZVA=
X-Received: by 2002:a05:600c:2951:: with SMTP id n17mr488448wmd.75.1575917381626;
 Mon, 09 Dec 2019 10:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
 <27b7642917479f9c17af30054abe1a72d0b121f7.camel@pengutronix.de> <94ec72a1-78a0-5a0e-ce52-ccc88e82e4d4@linaro.org>
In-Reply-To: <94ec72a1-78a0-5a0e-ce52-ccc88e82e4d4@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 9 Dec 2019 10:49:30 -0800
Message-ID: <CAHQ1cqF9AH=M7DtY3_DvB7RC-FvpiDRvk5LYx0QENhs_hO9W4w@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] QorIQ TMU multi-sensor and HWMON support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 9, 2019 at 10:20 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Lucas,
>
>
> On 06/12/2019 12:46, Lucas Stach wrote:
> > Hi all,
> >
> > can this series be considered for mainline inclusion? It has been
> > tested and works well in our i.MX8M kernel setup.
>
> I'm fine with the changes but the series does not longer apply. I tried
> to solve the conflicts but got too many of them.
>
> Is it possible to respin the series?
>

Yeah, no problem. Will do.

Thanks,
Andrey Smirnov
