Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E375D459
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfGBQhC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 12:37:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33650 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfGBQhC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 12:37:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so14724644qkc.0;
        Tue, 02 Jul 2019 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKVooiwPN88g+MgS3WlV5s1dsy7KSlDL3nSO/dSDKhQ=;
        b=TPK6Bl22nFAB5oGJu/i/fTzKhlfesH6ItfqRaoCzPS+A8ZDdwhG14ZDkHK642HV+hP
         gYYCeVbeIO5ZqUykWzhYTY1YfSPEmK/c0xSp3IFZWi910gsGHEq1eOcfV50+wLtnNlaB
         dVIlZLpjydcmWfOeSp5ZZoFV7EcuqXu8StP6B2K/vr3BQ/AdwDbHVVIbQ+fWDOF7s450
         9Es4yPfEvwgwrXo/zpYjB+gJ/JYb45siZ1wksjdqe2jV7dEhOogbY5FdV7ePntzgaqQN
         AHBtWE0nhIcgs6jmRhPeRAScPdr+13OpJTm2E/uJkjWHyD5IfQa5CBJZcw0WAS+DGw4l
         2Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKVooiwPN88g+MgS3WlV5s1dsy7KSlDL3nSO/dSDKhQ=;
        b=Giy7RAeuk/b//tkbycaMxZeMjw6xifFNZq6w1e5RfFXhN5N2XPyG5Y4g3HhxkrtxI0
         30tj+nykA07QJIdTKmiaslzR3KgqUkupHLuUnb3W3kU4GjWEnCzGePhkg8gCckvLWjFL
         ZMmd4DLJWC92JFVQiizjpcuavoV27XJhdp09HKGF6Hw4hf0uVYMkmlB6oEHNORPdqtOM
         D/n8CSL0E+Dyqkg7wZF3WgvuZAzoSrm5Um8CosWq98VBRwAoBKOBXxL+sjc3Jsq2qPow
         IkqPwSiWG7c4V2AhclQoaQiZE36+2556Zq4PcYvvnMQB2teQB1CfxoI1/GFwmFdujso2
         MnDA==
X-Gm-Message-State: APjAAAWFL0fNXyIItBDYaPYmJkTYAp4kthTwuY0QwYADS8jmmhkiz4nr
        oEq8kQC/sHvue8MqMvzxLhircW9ZD9T4qhX5PR8=
X-Google-Smtp-Source: APXvYqzSpJT1KCefnuTJ7ckiwvQe1Ni9mcyQHvPIyggQyr3AHqsH9gpU81HUpRWrIV1yF3Fgpyy7diUi4FBQKDeeEhc=
X-Received: by 2002:a37:ea0c:: with SMTP id t12mr24632370qkj.117.1562085421923;
 Tue, 02 Jul 2019 09:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190702161253.12016-1-smuchun@gmail.com>
In-Reply-To: <20190702161253.12016-1-smuchun@gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Wed, 3 Jul 2019 00:36:50 +0800
Message-ID: <CAPSr9jGo2ZLXS__B8oiiSBf0aTOivk1weUApxKrf20MZLz8G-A@mail.gmail.com>
Subject: Re: [PATCH] PM: Move disabling/enabling runtime PM to noirq
 suspend/early resume
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry, There are some problems with the subject, I have re-edited and
sent the v2 patch.

Update subject from:
           "PM: Move disabling/enabling runtime PM to noirq
suspend/early resume"
to:
           "PM: Move disabling/enabling runtime PM to suspend/resume noirq"
