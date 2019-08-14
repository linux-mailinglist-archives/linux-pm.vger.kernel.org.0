Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4193F8DCDA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfHNSUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 14:20:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44652 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfHNSUw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 14:20:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so5049780pfc.11
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=HxkHOON+igyo/l713j6Etvtbv36U/8Bq7y65v4eKNms=;
        b=UD0SSUoO8aTwyb9kPslWacrUoG5X0bIpq/DyPQGMkaW6VWlMLdvZLMyLYTjjwEMWcT
         mVQU3xE9fr+O2jTiKymOUWUjKIpRGJ9cNzViUfggoZjc3PQRdFcmLvAf2ng6tkHw/rQy
         ZPDMkY+zMLZJzJsbJLqx9EEkJAL1IvjRw5c+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=HxkHOON+igyo/l713j6Etvtbv36U/8Bq7y65v4eKNms=;
        b=RqrCVVuCd2CXA7OlRRyyQs0luwEUiSCUd55EzssY1LzmnkEDCA1v7+PuwJkfdbwWTz
         v4acqAlIPXhvLiu1PQIAiFvGp6UEVUqcOvntkToq4KQUtGAJFPuEEFujIKZsBlLDKXEf
         d6qV/0tlJNhjmTnQY6W5Bd61asnEf0cDLRPpU2hY/eZiGgMe6qqf7hyBNJKhqKaHreML
         4m1IhSKJBk8Xn6gU2aWpnnOqqfmAMGUKNiXOyMGZ6t4uy7Nh5TXxf8oqgBLyRyiiy5mL
         cyJ9IOyVvyw463ZLyUropufjHUU0lNscCgN9VqqhNM2XkrHIZFI2Is5HsDxJLC3otAVs
         9ouA==
X-Gm-Message-State: APjAAAU4iBLbYFzTs04TACS1rA5rjpA3KZposdkeMD9bq/eI9oVyKa/D
        /cwyubqhhFz5RSZYKzzSYWUFjw==
X-Google-Smtp-Source: APXvYqx6ADpbwi8aZ4KfkLTt9F7fFo35N5KzeXKchu7afafC3jPh4V4FsEqc6P7zhXgJHoohP28bsw==
X-Received: by 2002:a62:5c01:: with SMTP id q1mr1301258pfb.53.1565806851548;
        Wed, 14 Aug 2019 11:20:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z68sm322509pgz.88.2019.08.14.11.20.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:20:51 -0700 (PDT)
Message-ID: <5d545103.1c69fb81.5a8c2.0fdb@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813082442.25796-3-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org> <20190813082442.25796-3-mkshah@codeaurora.org>
Subject: Re: [PATCH 2/4] drivers: qcom: rpmh: remove rpmh_flush export
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 11:20:50 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-13 01:24:40)
> rpmh_flush() was exported with the idea that an external entity
> operation during CPU idle would know when to flush the sleep and wake
> TCS. Since, this is not the case when defining a power domain for the
> RSC. Remove the function export and instead allow the function to be
> called internally.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

