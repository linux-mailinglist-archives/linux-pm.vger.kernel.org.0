Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE3128F21
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 18:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVRnD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 12:43:03 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:41271 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 12:43:02 -0500
Received: by mail-io1-f43.google.com with SMTP id c16so10575750ioo.8;
        Sun, 22 Dec 2019 09:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QXEBHKU/LB1iiDp/zcMNr6eHfoj8s9pKx9O7xAvz4I=;
        b=Uh8AwjmyHmHNfIAuE42HV+aYzIViXpaRH7eN2qrJLEaexFijHEnU4ErU5uPmEoDOjH
         DuASs2LooE2RyySVRF037/epEY5D3Z1ouIhOA11wXfSAW1kTLvCBBZdsBKJn/Ekl0X94
         6koLKwsLkBZO/iXtAE8MktBxb3llTynwHfZJ2AYknWhlUvcvlUfdxKOjXnQoBxlqdedM
         VDm9Eh2GBSTLyp5DBoi1MLBva5AcfJXUOponC1+7SOmXJ0NF9LPD6/YvjfYSJ0rwkLxy
         F+PGF7zUNFZJBJZGhDSSMBCYsoBrhtaO8lkDOq7OytaDRZwX0WKC2RWRdVdb1NthpvHO
         YJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QXEBHKU/LB1iiDp/zcMNr6eHfoj8s9pKx9O7xAvz4I=;
        b=OxJEZYJSkIXhxHNbwH/4OMm4ocU45JxX/b7vQqx9DOb95wQSyCn6AEIUjGIIE3gUXM
         s79o/GwQZyPIL3FBIP7wPOUzZLdtyPw13199WUzoNh6AP+R1eAl1qN8foIBzq5cAcHkf
         XaqQtaSdYA+OHyJxhE5Dq8caesnureQv3CcX1fARSbKsI6OMwLwZQFq7yXKlPvdRLlMv
         t5ysSHJ8zHIqRayf+LNbJJdljauSmDxhTNVo/CLIzjtdXs7zonzyEVPvpaz92GcH0zTk
         ihnvDpyK2WXOUM21/3KRiq2yA0aqaGUE0Uwn1FuizZ8JBNOVTlQe/03r/X6csJJiny+F
         EUNw==
X-Gm-Message-State: APjAAAXQy3IITYJJvPcN6fCCedULnrpTb0BxLszVxRIWgaZHi7IXi4OD
        YBsQ62qWGTY3MZH3ZE2rI5rJdds5QD3EH/W1nPQ=
X-Google-Smtp-Source: APXvYqzBWA9in76G7bQs3kG+VdaKT1n50iAYQKSWWs0bg4iHRVOE63wih07E0eGxG8YRWphMlSn7GQjHQ28DWUUPGkw=
X-Received: by 2002:a5d:9eda:: with SMTP id a26mr18039071ioe.238.1577036581972;
 Sun, 22 Dec 2019 09:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20191221181855.31380-1-tiny.windzz@gmail.com> <CAGTfZH1aObSb5oWnVzp_WaGALFfC9VQpRKQ+AWTauPVL7VPOSg@mail.gmail.com>
In-Reply-To: <CAGTfZH1aObSb5oWnVzp_WaGALFfC9VQpRKQ+AWTauPVL7VPOSg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 23 Dec 2019 01:42:50 +0800
Message-ID: <CAEExFWs_UguSmPqHLZ02LVPmUBMcKC8vpwJ=DGxW6ve6JNhMVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / devfreq: rk3399_dmc: Add missing devfreq_event_disable_edev
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

V2 has been sent.

Thx,
Yangtao
