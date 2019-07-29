Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8507862F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfG2HUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 03:20:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38565 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2HUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 03:20:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so60570356wrr.5;
        Mon, 29 Jul 2019 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGAnXdnyTlrtK65biDfN+R0xcD/6ajBIRQzlf8iLxcA=;
        b=IVzn3FU5qq9wRwY7u5JJs1BkiXHdMdTrBdvwk8Jt4WShqOZBA47c3hzZDNZ3RYW4KW
         +IdO3+kqx0CQmXVR/5w//0hTu5ZLepZQk4+nIvMr70w/cMQ8Sc46OHlSGD4RQ4jGnhnJ
         4AeA1gTdhfVop/9UZJHN0bAoo7Iv5ACel8XHK/J85Sd5PQCQfOSbBB3nYWHVhfj5myz0
         f7xcEQ8Vn5CYlOh2UzkE/KszbJSLki6CA5Wz5JIhhZ6ZAqkNP7VhhzHwYuZmVlYtgpFq
         lqPe6Iwn9TMTSoXgRBoW7BbsEzBhvbZNdU670/nGINNOj0yJo2CH4aeeqm9LrD7aG38m
         lV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGAnXdnyTlrtK65biDfN+R0xcD/6ajBIRQzlf8iLxcA=;
        b=cWo8cs+B3MR6Z+hlot7LjHNpdmXhB2AZabB1G6uc8WXl3uAuV57dPZOm+HqYrZqf9d
         19dA8bu6lKhSB56oUIiepSL4IsZcx2L5FcrHGma+pJvMIDJ1wfRgHejAbD2reRPkbyA/
         9mQm4JMBKFANUONfHF77EGf4pIwJfhfp+Tz+UoAm7rN2WkVtTJUWGgq7yCfXFGazuwlQ
         gSWYAs/0icqq0booVy8PyW0EbrVCv2YW1gdn53E0SOMEJn0Y2rUfViV8K5+dfJemwDUW
         jYcmZgcI64s5tZB4CvnZqAzXPk8O5oWzkApoNLMfDr5GsSP6ERC1kR+groOFwBL8GYUE
         ZS5w==
X-Gm-Message-State: APjAAAWsfMouc7/N73mP3oWW9irNDxiCFDXb7S14s6QhaRgtlhRSbr4l
        SjUSFd5oaNY3Nb+RyC6haJGXUVLWMLdqI8VKCbQ=
X-Google-Smtp-Source: APXvYqxtBXh9XypbQCggtX40yh034dlUxuLKuPCiBaZSuYbNdbqeWex1ATByZQcE6PXfNMdArNjf9paTKtKnFSuc4uI=
X-Received: by 2002:adf:c70e:: with SMTP id k14mr15959399wrg.201.1564384835131;
 Mon, 29 Jul 2019 00:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
 <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175> <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZB6tmYFA8wwh0Fm49LTTDuCLq-SWVfrcUkRWWBo=0U13w@mail.gmail.com> <DB3PR0402MB391627F725AA7237BCACBE87F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391627F725AA7237BCACBE87F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 Jul 2019 10:20:23 +0300
Message-ID: <CAEnQRZBrmikenTvnh7syhy=PDPcTL3fn2TJ+ya=ToZ+SFmH5tw@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

<snip>
> > Your explanation makes a lot of sense. We will take care today of Abel's
> > patch.
> > What do you think about Fabio's patch? I also think this is a valid patch:
> >
<snip>

>
> Hmm, when did Fabio sent out this patch? I can NOT find it...
> I also have a patch in this series (#4/6) doing same thing on July 5th...
>
> https://patchwork.kernel.org/patch/11032783/

He didn't send the patch yet. It was just a request for test here:

http://code.bulix.org/pd88jp-812381

But, now I see is exactly like your patch here:
