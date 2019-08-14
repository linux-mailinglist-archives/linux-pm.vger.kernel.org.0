Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31D38DCD6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfHNSTc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 14:19:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45334 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfHNSTc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 14:19:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so53476753pgp.12
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=cemWnJlXygQVUHs5+9IULKNWTiOcpifvvGT6fgr1/ss=;
        b=bSWNJRfNBipTymbkmcbI5jJ3xyct+DaLS3dGG6WRYspIUm5G+b1NTo0h1QJTLpvS7m
         J5I65FRuW6QrGcoTfpiTZgdQCr5st4md64gdF/URuzzvrSyp8enuxe4pg4FyEk7nkNrc
         zolJ+z234CDVbXYq6L2hbnJQvCju5CwF5qCjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=cemWnJlXygQVUHs5+9IULKNWTiOcpifvvGT6fgr1/ss=;
        b=IX+irLfFfKSxvnKDkmgFahqgVpMeUieh8cPTJbqga7OjYvZvKseQbGgteCZbA7ChIn
         rQh/kWo+ltGk9ugnvwW4iRAoJ6jJropEDTU+FFgla+Ow58V+dGdxHOVfTcqF1TPryAC9
         ecTCb2KsY990hNUDhmYrI3PmssihrxEENo1KNiPRueJ+6HU/XZSH/3eunZbVTc1aYHDU
         X09+VMCkEYazT0rJQmdT55XkjimT7SqMcGd/xyJjbYj09TUZBOnSn1MK/eFMqPGnkSrR
         Kz7DoPZE1FvzrhCcH/6DO6qV18kNF4Knl5iulKCQDIKRogN3hFluTzejS8JWUKUdXfre
         5vdw==
X-Gm-Message-State: APjAAAX0j1hKAakhi0zHE/5wyD67LQZvyrDMHPtHxMgJ7dgyreAIg5B3
        uGYa3ZQAvyKcoclESKi9Skh1Tg==
X-Google-Smtp-Source: APXvYqyq21lgcDuREFVcb4CjJEe4M1+jIFdEW9koO5WaBv/ywvDRXPU6oHaKN9VXlRtTSxSUXPMCmA==
X-Received: by 2002:a65:518a:: with SMTP id h10mr398117pgq.117.1565806771571;
        Wed, 14 Aug 2019 11:19:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o4sm790460pje.28.2019.08.14.11.19.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:19:30 -0700 (PDT)
Message-ID: <5d5450b2.1c69fb81.ec1c1.1cb2@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813082442.25796-1-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org>
Subject: Re: [PATCH 0/4] Add RSC power domain support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 11:19:29 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-13 01:24:38)
> Resource State Coordinator (RSC) is responsible for powering off/lowering
> the requirements from CPU subsystem for the associated hardware like buse=
s,
> clocks, and regulators when all CPUs and cluster is powered down.
>=20
> RSC power domain uses last-man activities provided by genpd framework bas=
ed on
> Ulf Hansoon's patch series[1], when the cluster of CPUs enter deepest idle
> states. As a part of domain poweroff, RSC can lower resource state requir=
ements
> by flushing the cached sleep and wake state votes for resources.

This series looks like half the solution. Is there a full set of patches
that connects the RPMh power domain to cpuidle and genpds?

