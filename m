Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3040F8DC96
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHNSCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 14:02:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37467 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfHNSCJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 14:02:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so20650445pgp.4
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=WfxA1A737XoI5ZZ/Hf4Cr2tS9xoxZFvNR1WhcJSUChE=;
        b=nbuuCGGLRs2jIpwx5obA8WHvJ1rd4HSPNnsO6jd7X4i8etCRuSwgpoU5UUSuHhgGmB
         yxxNkVHq72XrgE08a6AU6gQV0mgSYgifC1WnkUrRYPLW5PZa3h88lqtpphXfdJX9HwCP
         r/KDowHHZ6yYZvOXVfENrcjMJZBXe1xYx6Uso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=WfxA1A737XoI5ZZ/Hf4Cr2tS9xoxZFvNR1WhcJSUChE=;
        b=Tib6bRG/4Me11PUnt/iNlRRFDPQvaEX791wM2PxaU0UO57IFx+ajt0XvcsJkbfDkYi
         uEA+GaLu2nm/vmjkmWwtTxzg5tcdhdyXePZaJhAaLpgIKSKPZGaD+XIhyEXhsjTpYWGA
         PqLkCVG3c/1cqbjUGwE1GooO4ub0M9L2Gun1CjBBLRw8JSnjPjuYEFsyB20iNh+P1Kml
         uQ+FUpaUO6rbYWAtZyenYEqwwhaFve2eNVXQuQ0ebBqw5zIWmxjn2M9NSRfHVXqrqyE6
         NG5iLxLwY478tv8uNhlhj3UhY9L3yriuMtqx+YCnB+DrArL+5+2S0ulqe9j4Tgaszr7o
         5dEg==
X-Gm-Message-State: APjAAAV2TSwhLYwlWOfjKB92VPpOj0Lp507gLmQkVbU4GNgSAGCXFN3I
        KtdmKCuGzAHdAG3hk754qSoDoQ==
X-Google-Smtp-Source: APXvYqwk4DMeNeDAM10WFbJ0Wxfbl3zzpawQoDzKGmcpMx0DkwBbVOGhCtuG5YmdXcz2nCdcgwAyTQ==
X-Received: by 2002:a17:90b:14c:: with SMTP id em12mr971132pjb.28.1565805728996;
        Wed, 14 Aug 2019 11:02:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 185sm601094pff.54.2019.08.14.11.02.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:02:08 -0700 (PDT)
Message-ID: <5d544ca0.1c69fb81.a98a7.19e1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813082442.25796-4-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org> <20190813082442.25796-4-mkshah@codeaurora.org>
Subject: Re: [PATCH 3/4] dt-bindings: soc: qcom: Add RSC power domain specifier
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 11:02:07 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-13 01:24:41)
> In addition to transmitting resource state requests to the remote
> processor, the RSC is responsible for powering off/lowering the
> requirements from CPUs subsystem for the associated hardware like
> buses, clocks, and regulators when all CPUs and cluster is powered down.
>=20
> The power domain is configured to a low power state and when all the
> CPUs are powered down, the RSC can lower resource state requirements
> and power down the rails that power the CPUs.
>=20
> Add PM domain specifier property for RSC controller.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

