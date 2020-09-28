Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9327727ACEB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 13:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1LfN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 07:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1LfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 07:35:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5153AC061755;
        Mon, 28 Sep 2020 04:35:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gr14so8064007ejb.1;
        Mon, 28 Sep 2020 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=H54mErN7yVeSyiSMCbQutLCzpzIzf9ZISuru6EqV53Y=;
        b=MxSgjektmvs+k5buqD7e84mMn+BejuRg+/7pd4MeKluPbeiDLliOb9WH4axU8JFm30
         dvvRlZAqWzxYu1WzhBI4drkdz2pN8Jja5+JLaZdZcY0VO/ez/EB5AtcxcgWc7oUC9QlB
         YeKz0bVGViHSZ3I+msg6EZNLLgSzStzhy7oqZAzeo/pPkOSEOXE38SCbmwH7FfZevjJD
         arRm0XJ5ae2zl6Nq/u7LrD6ibxoxuIklInN089XpQ9NNlHUeETNr2Ht4BxJPfmt312b7
         jJOTnCF6grxFeUgLBBDMxSZqJtBVYpE4EiEjz0lHBZnn6uJjrBYrg3ox/Sm+ZqwB+geO
         9tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=H54mErN7yVeSyiSMCbQutLCzpzIzf9ZISuru6EqV53Y=;
        b=NGJFK1mExkyL0ClSnlTmX/HHEzVua/B0BF2ThiBP23X2uOgO2OJBzaUqcGc/OHqicE
         uSxvT0k9IhdGqWWiUboVaFW8wwnzbNKlMKf1pFvV+BcTSzMpsPvk5vPnmI4y7uUQp4v1
         idjZJAAS9GrPuPtNdz7ca4qzWfdgnVMQ2DZMjd+Sd8tMtozP5FT3wa/zGI8+yWyoOQ6+
         4rA8gLsocgloiUGn0TZZn+lF3xPeNDsFL9Yabe8F04cAOTN0cpmJMsU8305BWH2/r1fk
         7wnXMkBcs4eTEDczUQoe03Ft6nhzKbcTvMOnVtSgCTDbaFsvjCyTOkaj8rRbO7s015DI
         TuUg==
X-Gm-Message-State: AOAM531r3QiLl3JVvQXxycP555uPdyFihRP+k61hQdn7iX4kJrxWBxqH
        v5JzdSL8G4mMFWJH4Cw0IhU=
X-Google-Smtp-Source: ABdhPJyeH0MheGAETpC+2xQtn94x3NATOZ8jYqhUtyA8qgWtvvTv2aTMyzjRjpO3uWi1OSVUCG2kfQ==
X-Received: by 2002:a17:906:594c:: with SMTP id g12mr1212711ejr.347.1601292911288;
        Mon, 28 Sep 2020 04:35:11 -0700 (PDT)
Received: from AnsuelXPS (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.gmail.com with ESMTPSA id y9sm893360ejw.96.2020.09.28.04.35.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 04:35:10 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Amit Kucheria'" <amitk@kernel.org>
Cc:     "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Zhang Rui'" <rui.zhang@intel.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'linux-arm-msm'" <linux-arm-msm@vger.kernel.org>,
        "'Linux PM list'" <linux-pm@vger.kernel.org>,
        "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>
References: <20200814134123.14566-1-ansuelsmth@gmail.com> <CAHLCerM666W9ijLu529NNPNz_NuyO0QPKws8spWrR4bWNo0A-A@mail.gmail.com>
In-Reply-To: <CAHLCerM666W9ijLu529NNPNz_NuyO0QPKws8spWrR4bWNo0A-A@mail.gmail.com>
Subject: RE: [RFC PATCH v6 0/8] Add support for ipq8064 tsens
Date:   Mon, 28 Sep 2020 13:35:09 +0200
Message-ID: <00b901d6958b$6c320ae0$449620a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQKNSg84Txe44YHglS9ra7bUDGlM1AMS+IIEp/fqk8A=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Amit Kucheria <amitk@kernel.org>
> Sent: Monday, September 28, 2020 1:33 PM
> To: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Andy Gross <agross@kernel.org>; Bjorn Andersson
> <bjorn.andersson@linaro.org>; Zhang Rui <rui.zhang@intel.com>; Daniel
> Lezcano <daniel.lezcano@linaro.org>; Rob Herring <robh+dt@kernel.org>;
> linux-arm-msm <linux-arm-msm@vger.kernel.org>; Linux PM list <linux-
> pm@vger.kernel.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE
> TREE BINDINGS <devicetree@vger.kernel.org>; LKML <linux-
> kernel@vger.kernel.org>
> Subject: Re: [RFC PATCH v6 0/8] Add support for ipq8064 tsens
> 
> Hi Ansuel,
> 
> Just a quick note to say that I'm not ignoring this, just on
> vacations. I'll be back to review this in a few days.
> 
> Regards,
> Amit
> 

Thx a lot. Was thinking of resending this but I will wait.


