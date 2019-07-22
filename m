Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D582F70D5F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 01:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfGVXfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 19:35:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40178 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGVXfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 19:35:04 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so77814041iom.7;
        Mon, 22 Jul 2019 16:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1l4y3t2UMkEkO+/MJw8aq8fSMYsxde02LarPu3Ozik=;
        b=ZkUvj4cBeAW+x/BaVktMrSHfQkkWUySP21C/SpHbVPlPzwo7rJwqT4lYcClNpOAjRw
         hv8FxCZWvOfyWFwFujwi16xOoyQgUQPDjJB8CfF7otkaDBU01GAm2Qx0OzllZtrVQgU2
         6HMGS7cWwGiFeQz0kPUR+AQeCX3e/7FYqvcemPGlo9zmu6/zIPRp714BnKFY7ubpKAtr
         4+PeYP2JQxsVKNhJYcc9LpNptQDiSl1WKU10loHDHwPC8ZALpb3W7nQnjSmaRatp6KrL
         ic7LPdzafuyaEKfiqXs4PKeVHS5gqWp+5SQ8xjKjlnh+4VHTkEPDSciCFkf62HZVxiOi
         ebSA==
X-Gm-Message-State: APjAAAUHLw/nZcSp5IuZanQcy7hTEdi+fupBsDPgacyeRrbgrEYE4PSy
        EeB0FULVJuHv/NSTfLgwzg==
X-Google-Smtp-Source: APXvYqxPtT8L1B/fbW9iJFp4+RBI7uFqvTbw19TSSehSOpu+f76R4vtucET4OI7dIY9HOM2hAJhqNA==
X-Received: by 2002:a6b:dd17:: with SMTP id f23mr55075087ioc.213.1563838503145;
        Mon, 22 Jul 2019 16:35:03 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v10sm36428164iob.43.2019.07.22.16.35.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:35:02 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:35:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
Message-ID: <20190722233501.GA19594@bogus>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org>
 <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 11:58:08AM -0700, Saravana Kannan wrote:
> On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> >
> > Hey Saravana,
> >
> > https://patchwork.kernel.org/patch/10850815/
> > There was already a discussion ^^ on how bandwidth bindings were to be
> > named.
> 
> Yes, I'm aware of that series. That series is trying to define a BW
> mapping for an existing frequency OPP table. This patch is NOT about
> adding a mapping to an existing table. This patch is about adding the
> notion of BW OPP tables where BW is the "key" instead of "frequency".
> 
> So let's not mixed up these two series.

Maybe different reasons, but in the end we'd end up with 2 bandwidth 
properties. We need to sort out how they'd overlap/coexist.

The same comment in that series about defining a standard unit suffix 
also applies to this one.

Rob
